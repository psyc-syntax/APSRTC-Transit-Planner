import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/database_helper.dart';

import 'package:planner_demo/logic/trip_id_generator.dart';
import 'package:planner_demo/providers/providers.dart';

import '../models/app_data.dart';

bool isTripSaved(WidgetRef ref, Result result) {
      final trips = ref.watch(savedTripsProvider);

      final id = generateTripId(result);

      for (final trip in trips) {
        if (generateTripId(trip) == id) {
          return true;
        }
      }

      return false;
}
Future<void> deleteTrip(
    WidgetRef ref,
    Result result,
) async{

  await DatabaseHelper().deleteTrip(result);

  final trips =
      ref.read(savedTripsProvider);

  final id = generateTripId(result);

  ref.read(savedTripsProvider.notifier).state =

      trips.where((trip){

        return generateTripId(trip)!=id;

      }).toList();

}