import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import '../widgets/stop seraching/search_title.dart';
import 'package:planner_demo/widgets/shared/stop_basic_details_card.dart';

class StopSearchScreen extends StatefulWidget {
  const StopSearchScreen({super.key, required this.isbackneeded});

  final bool isbackneeded;

  @override
  State<StopSearchScreen> createState() => _StopSearchScreenState();
}

class _StopSearchScreenState extends State<StopSearchScreen> {
  final TextEditingController controller = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> stops = [];
  bool isloading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchStops(""); // 🔥 load all data initially
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> searchStops(String query) async {
    setState(() {
      isloading = true;
    });

    try {
      final result = await _databaseHelper.getsearchstops(query);

      print("RESULT COUNT: ${result.length}");

      setState(() {
        stops = result;
        isloading = false;
      });
    } catch (e) {
      print("ERROR: $e");

      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  SafeArea(child: SearchTitle(isbackneeded: widget.isbackneeded)),

                  // 🔍 YOUR SAME TEXTFIELD UI
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        // 🔥 DEBOUNCE
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }

                        _debounce = Timer(
                          const Duration(milliseconds: 300),
                          () {
                            searchStops(value);
                          },
                        );

                        setState(() {}); // update header visibility
                      },
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
                        fillColor:
                            const Color.fromARGB(96, 211, 225, 250),
                        hintStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.primary,
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
            child: _buildResults(isSearching),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(bool isSearching) {
    if (isloading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (stops.isEmpty) {
      return const Center(child: Text("No results Found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
      itemCount: stops.length + (isSearching ? 0 : 1),
      itemBuilder: (context, index) {
        // 🔥 HEADER ONLY WHEN NOT SEARCHING
        if (!isSearching && index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "POPULAR / NEARBY - STOPS",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }

        final stop = stops[isSearching ? index : index - 1];

        return StopBasicDetailsCard(
          stopName: stop["placeName"] ?? "",
          district: stop["district"] ?? "",
          pincode: stop["pincode"]?.toString() ?? "",
          address: stop["address"] ?? "",
        );
      },
    );
  }
}