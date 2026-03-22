import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/search_screen_data_provider.dart';
import '../widgets/stop seraching/search_title.dart';
import 'package:planner_demo/widgets/shared/stop_basic_details_card.dart';

class StopSearchScreen extends ConsumerStatefulWidget {
  const StopSearchScreen({super.key, required this.isbackneeded});

  final bool isbackneeded;

  @override
  ConsumerState<StopSearchScreen> createState() => _StopSearchScreenState();
}

class _StopSearchScreenState extends ConsumerState<StopSearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void searchStops(String query) {
    ref.read(searchScreenDataProvider.notifier).searchStops(query);
  }

  @override
  Widget build(BuildContext context) {
    final stops = ref.watch(searchScreenDataProvider);
    final isSearching = controller.text.isNotEmpty;

    return Scaffold(
      body: Column(
        children: [
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
                children: [
                  const SizedBox(height: 36),
                  SearchTitle(isbackneeded: widget.isbackneeded),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: TextField(
                      controller: controller,
                      onChanged: searchStops,
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: Colors.black54),

                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),

                        hintText: "SELECT STOP",

                        filled: true,
                        fillColor: const Color.fromARGB(96, 211, 225, 250),

                        hintStyle: Theme.of(context).textTheme.headlineSmall
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
          Expanded(
            child: isSearching
                ? _buildSearchResults(stops)
                : _buildPopularStops(stops),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List stops) {
    if (stops.isEmpty) {
      return const Center(child: Text("No results Found"));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
      itemCount: stops.length,
      itemBuilder: (context, index) {
        final stop = stops[index];
        return StopBasicDetailsCard(
          stopName: stop.name,
          district: stop.address[1],
          pincode: stop.address[0],
          panchayat: stop.address[2],
        );
      },
    );
  }

  Widget _buildPopularStops(List stops) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
      itemCount: stops.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "POPULAR / NEARBY - STOPS",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }
        final stop = stops[index - 1];
        return StopBasicDetailsCard(
          stopName: stop.name,
          district: stop.address[1],
          pincode: stop.address[0],
          panchayat: stop.address[2],
        );
      },
    );
  }
}
