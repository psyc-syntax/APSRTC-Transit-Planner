
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> prepareBinaryFiles() async {
  final dir = await getApplicationDocumentsDirectory();

  final files = [
    'B_arr.bin',
    'R_arr.bin',
    'B_index.bin',
    'R_index.bin',
  ];

  for (final name in files) {
    final file = File('${dir.path}/$name');

    if (!await file.exists()) {
      print('Copying $name...');

      final data = await rootBundle.load(
        'assets/bin files/$name',
      );

      await file.writeAsBytes(
        data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        ),
      );
    } else {
      print('$name already exists');
    }
  }

  print('Binary folder: ${dir.path}');

  return dir.path;
}