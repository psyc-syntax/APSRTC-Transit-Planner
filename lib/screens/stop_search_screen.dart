import 'package:flutter/material.dart';
import 'package:planner_demo/data/dummy_data.dart';
import 'package:planner_demo/models/bus_stop.dart';
import '../widgets/stop seraching/search_title.dart';
import 'package:planner_demo/widgets/shared/stop_basic_details_card.dart';

class StopSearchScreen extends StatefulWidget {
  const StopSearchScreen({super.key,});

  @override
  State<StopSearchScreen> createState() {
    return _StopSearchScreen();
  }
}

class _StopSearchScreen extends State<StopSearchScreen> {
  List<BusStop> _filteredStops = busStops;
  bool isTextFieldActive = false;

  final TextEditingController controller = TextEditingController();

  void searchStops(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredStops = busStops;
        isTextFieldActive = false;
      });
      return;
    }

    final results = busStops.where((stop) {
      final name = stop.name.toLowerCase();
      final pincode = stop.address[0];
      final panchayat = stop.address[2].toLowerCase();

      return name.startsWith(query.toLowerCase()) ||
          pincode.startsWith(query) ||
          panchayat.startsWith(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredStops = results;
      isTextFieldActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// HEADER CARD
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 36),

                  /// TITLE
                  const MainTitle(),

                  /// SEARCH FIELD
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: TextField(
                      controller: controller,
                      onChanged: searchStops,
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black54),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        hintText: "Search Stop",
                        filled: true,
                        fillColor: const Color.fromARGB(96, 211, 225, 250),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// RESULTS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(26),
              itemCount: isTextFieldActive
                  ? _filteredStops.length
                  : _filteredStops.length + 1,
              itemBuilder: (context, index) {
                /// HEADER
                if (index == 0 && !isTextFieldActive) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "POPULAR / NEARBY - STOPS",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }

                /// GET STOP
                final stop =
                    _filteredStops[isTextFieldActive ? index : index - 1];

                /// CARD
                return StopBasicDetailsCard(
                  stopName: stop.name,
                  district: stop.address[1],
                  pincode: stop.address[0],
                  panchayat: stop.address[2],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}