import 'dart:convert';
import 'dart:isolate';
import 'dart:ffi' as native;
import 'package:ffi/ffi.dart' as pkg_ffi;
import 'package:planner_demo/helpers/bin_files_helper.dart';
import 'package:sqlite3/sqlite3.dart' as ffi;
import 'package:planner_demo/logic/distance_time__calculator_by_lat_lon.dart';
import 'package:planner_demo/models/app_data.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:sqlite3/sqlite3.dart';

typedef MarksAlgorithmNative =
    native.Pointer<pkg_ffi.Utf8> Function(
      native.Int16 src,
      native.Int16 dest,
      native.Int16 startTime,
      native.Int16 endTime,
      native.Int16 estimatedTime,
      native.Pointer<pkg_ffi.Utf8> dataPath,
    );

typedef MarksAlgorithmDart =
    native.Pointer<pkg_ffi.Utf8> Function(
      int src,
      int dest,
      int startTime,
      int endTime,
      int estimatedTime,
      native.Pointer<pkg_ffi.Utf8> dataPath,
    );

typedef FreeResultNative = native.Void Function(native.Pointer<pkg_ffi.Utf8>);
typedef FreeResultDart = void Function(native.Pointer<pkg_ffi.Utf8>);

final native.DynamicLibrary _nativeLib = native.DynamicLibrary.open(
  'marks_engine.so',
);

final MarksAlgorithmDart _marksAlgorithm = _nativeLib
    .lookup<native.NativeFunction<MarksAlgorithmNative>>('marksAlgorithm')
    .asFunction();

final FreeResultDart _freeResult = _nativeLib
    .lookup<native.NativeFunction<FreeResultNative>>('freeMarksResult')
    .asFunction();

Future<String> _callNativeAlgorithm(
  int src,
  int dest,
  int startTime,
  int endTime,
  int estimatedTime,
) async {

  // 1. Prepare/copy the binary files
  final String dataPath = await prepareBinaryFiles();

  print('Dart dataPath: $dataPath');

  // 2. Convert Dart String -> Pointer<Utf8>
  final native.Pointer<pkg_ffi.Utf8> pathPointer =
      dataPath.toNativeUtf8();

  try {

    // 3. Call C++
    final resultPointer = _marksAlgorithm(
      src,
      dest,
      startTime,
      endTime,
      estimatedTime,
      pathPointer,
    );

    // 4. Convert C++ char* -> Dart String
    final String result = resultPointer.toDartString();

    print('C++ result: $result');

    // 5. Free memory allocated by C++
    _freeResult(resultPointer);

    return result;

  } finally {

    // 6. Free memory allocated by Dart for dataPath
    pkg_ffi.calloc.free(pathPointer);
  }
}
int? _getPlaceIdInt(ffi.Database db, String placeId) {
  final rows = db.select(
    'SELECT id FROM mapped_placeId WHERE old_placeId = ?',
    [placeId],
  );
  if (rows.isEmpty) return null;
  return rows.first['id'] as int;
}

Map<int, String> _loadAllPlaceIds(ffi.Database db) {
  final Map<int, String> map = {};
  final rows = db.select('SELECT id, old_placeId FROM mapped_placeId');
  for (final row in rows) {
    map[row['id'] as int] = row['old_placeId'].toString();
  }
  return map;
}

Map<int, String> _loadAllOprsNos(ffi.Database db) {
  final Map<int, String> map = {};
  final rows = db.select('SELECT id, old_oprsNo FROM mapped_oprsNo');
  for (final row in rows) {
    map[row['id'] as int] = row['old_oprsNo'].toString();
  }
  return map;
}

List<Result> _jsonToResult(
  String jsonText,
  Map<int, String> placeIdMap,
  Map<int, String> oprsNoMap,
) {
  List<Result> results = [];

  final List<dynamic> trips = jsonDecode(jsonText);

  for (final tripData in trips) {
    final List<dynamic> legs = tripData;

    if (legs.isEmpty) continue;

    final List<PathStop> path = [];

    for (final legData in legs) {
      final int placeIdInt = legData['placeId'];
      final int oprsNoInt = legData['oprsNo'];
      final int depTime = legData['dep'];
      final int arrTime = legData['arr'];

      final String placeId = placeIdMap[placeIdInt] ?? placeIdInt.toString();

      final String oprsNo = (oprsNoInt == -1)
          ? ''
          : (oprsNoMap[oprsNoInt] ?? oprsNoInt.toString());

      int travelMinutes = arrTime - depTime;
      if (travelMinutes < 0) travelMinutes += 1440;

      path.add(
        PathStop(
          placeId: placeId,
          placeName: '',
          arrivalTime: arrTime,
          deptTime: depTime,
          oprsNo: oprsNo,
        ),
      );

      final int finalArrivalTime = path.last.arrivalTime;
      results.add(Result(path, finalArrivalTime));
    }
  }

  return results;
}

Future<List<Result>> marksScheduleAlgorithm(
  String sourcePlaceId,
  String destinationPlaceId,
  int startTime,
  int endTime,
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) async {
  if (sourcePlaceId.isEmpty || destinationPlaceId.isEmpty) return [];

  final dbPath = await DatabaseHelper().getDatabaseFilePath();
  final double estimatedTime = getEstimatedTimeByLatLon(lat1, lon1, lat2, lon2);

  print(
    "MARKS Schedule: $sourcePlaceId -> $destinationPlaceId [$startTime-$endTime]",
  );

  return await Isolate.run(() async {
    final db = sqlite3.open(dbPath);

    try {
      final int? src = _getPlaceIdInt(db, sourcePlaceId);
      final int? dest = _getPlaceIdInt(db, destinationPlaceId);

      if (src == null || dest == null) {
        print("MARKS Schedule: could not find src or dest in mapped_placeId");
        return <Result>[];
      }

      final placeIdMap = _loadAllPlaceIds(db);
      final oprsNoMap = _loadAllOprsNos(db);

      final String jsonText = await _callNativeAlgorithm(
        src,
        dest,
        startTime,
        endTime,
        estimatedTime.round(),
      );

      final List<Result> results = _jsonToResult(
        jsonText,
        placeIdMap,
        oprsNoMap,
      );

      _enrichResults(results, db);

      return results;
    } finally {
      db.dispose();
    }
  });
}

void _enrichResults(List<Result> results, ffi.Database db) {
  if (results.isEmpty) return;

  final Set<String> allPlaceIds = {};
  final Set<String> allOprsNo = {};

  for (final r in results) {
    for (final stop in r.path) {
      allPlaceIds.add(stop.placeId);
      if (stop.oprsNo.isNotEmpty) allOprsNo.add(stop.oprsNo);
    }
  }

  final Map<String, String> nameLookUp = {};
  final Map<String, Map<String, String>> stopDetailsLookUp = {};

  if (allPlaceIds.isNotEmpty) {
    final ph = List.filled(allPlaceIds.length, '?').join(',');

    final rows = db.select(
      'SELECT * FROM place_master WHERE placeId IN ($ph)',
      allPlaceIds.toList(),
    );

    for (final row in rows) {
      final id = row['placeId'].toString();
      nameLookUp[id] = row['placeName']?.toString() ?? '';
      stopDetailsLookUp[id] = {
        'placeId': id,
        'placeName': row['placeName']?.toString() ?? '',
        'pincode': row['pincode']?.toString() ?? '',
        'address': row['address']?.toString() ?? '',
        'landmark': row['landmark']?.toString() ?? '',
        'latitude': row['latitude']?.toString() ?? '',
        'longitude': row['longitude']?.toString() ?? '',
        'district': row['district']?.toString() ?? '',
      };
    }
  }

  final Map<String, String> serviceTypeLookup = {};
  final Map<String, String> vehicleNoLookup = {};

  if (allOprsNo.isNotEmpty) {
    final ph = List.filled(allOprsNo.length, '?').join(',');
    final rows = db.select('''
      SELECT oprsNo, vehicleNumber, serviceType
      FROM service_details
      WHERE oprsNo IN ($ph)
    ''', allOprsNo.toList());
    for (final row in rows) {
      final id = row['oprsNo'].toString();
      serviceTypeLookup[id] = row['serviceType']?.toString() ?? '';
      vehicleNoLookup[id] = row['vehicleNumber']?.toString() ?? '';
    }
  }

  for (int ri = 0; ri < results.length; ri++) {
    final List<PathStop> enriched = results[ri].path.map((stop) {
      return PathStop(
        placeId: stop.placeId,
        placeName: nameLookUp[stop.placeId] ?? stop.placeName,
        arrivalTime: stop.arrivalTime,
        deptTime: stop.deptTime,
        oprsNo: stop.oprsNo,
        time: stop.time,
        distance: stop.distance,
        serviceType: serviceTypeLookup[stop.oprsNo] ?? stop.serviceType,
        vehicleNo: vehicleNoLookup[stop.oprsNo] ?? stop.vehicleNo,
        stopDetails: stopDetailsLookUp[stop.placeId] ?? stop.stopDetails,
      );
    }).toList();
    results[ri] = Result(enriched, results[ri].time);
  }
}
