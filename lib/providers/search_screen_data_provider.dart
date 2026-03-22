import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/data/dummy_data.dart';
import 'package:planner_demo/models/bus_stop.dart';

class SearchScreenData extends Notifier<List<BusStop>> {
  @override
  List<BusStop> build() {
    return busStops; // initial full list
  }

  void searchStops(String query) {
  if (query.isEmpty) {
    state = busStops;
    return;
  }

  final results = busStops.where((stop) {
    final name = stop.name.toLowerCase();

    final address = stop.address;

    final pincode =
        address.isNotEmpty ? address[0] : '';

    final panchayat =
        address.length > 2 && address[2] != ''
            ? address[2].toLowerCase()
            : '';

    return name.startsWith(query.toLowerCase()) ||
        pincode.startsWith(query) ||
        panchayat.startsWith(query.toLowerCase());
  }).toList();

  state = results;
}
}

final searchScreenDataProvider =
    NotifierProvider.autoDispose<SearchScreenData, List<BusStop>>(
  SearchScreenData.new,
);