import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';
import 'package:planner_demo/widgets/shared/stop_basic_details_card.dart';

class StopSearchScreen extends StatefulWidget {
  const StopSearchScreen({
    super.key,
    required this.isbackneeded,
    required this.isStartingStop,
  });

  final bool isbackneeded;
  final bool isStartingStop;

  @override
  State<StopSearchScreen> createState() => _StopSearchScreenState();
}

class _StopSearchScreenState extends State<StopSearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> stops = [];
  bool isloading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchStops("");

    //load all data initially

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> searchStops(String query) async {
    setState(() {
      isloading = true;
    });

    try {
      final result = await _databaseHelper.getSearchStops(query);

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
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          SafeArea(
          bottom: false,
          top: true,
          left: true,
          right: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    
        
                    if(!_focusNode.hasFocus) TopTitle(isbackNeeded: widget.isbackneeded, title: "Select Stop"),
        
                    // TEXTFIELD UI
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: TextField(
                        controller: controller,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          //DEBOUNCE
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
                        style: Theme.of(context).textTheme.titleSmall,
        
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: _focusNode.hasFocus
                              ? InkWell(
                                onTap: () {
                                  controller.clear();
                                  searchStops("");
                                  _focusNode.unfocus();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 22,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              )
                              : Icon(
                                  Icons.search,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  size: 22,
                                ),
        
                          prefixIconConstraints: _focusNode.hasFocus
                              ? const BoxConstraints(minWidth: 46, minHeight: 46)
                              : const BoxConstraints(minWidth: 46, minHeight: 46),
        
                          hintText: "Select stop or city...",
                          
                          filled: true,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          hintStyle: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
        
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
        
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              Expanded(child: _buildResults(isSearching)),
            ],
          ),
        ),

        if(widget.isbackneeded)Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100, // Height covers the floating card background buffer area perfectly
            child: IgnorePointer(
              // CRITICAL: IgnorePointer ensures users can still scroll or click elements through the gradient overlay
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0), // Starts fully transparent
                      bgColor.withOpacity(0.8), // Smooth transition buildup
                      bgColor,                  // Ends completely solid at the device edge
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ]
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
  
      itemCount: stops.length + (isSearching ? 0 : 1),
      itemBuilder: (context, index) {
        //HEADER ONLY WHEN NOT SEARCHING
        if (!isSearching && index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              "Popular / Nearby - Stops",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }

        final stop = stops[isSearching ? index : index - 1];

        return StopBasicDetailsCard(
          stopName: stop["placeName"] ?? "",
          district: stop["district"] ?? "",
          pincode: stop["pincode"]?.toString() ?? "-",
          address: stop["address"] ?? "",
          placeId: stop["placeId"]?.toString() ?? "-",
          latitude: stop["latitude"]?.toString() ?? "-",
          longitude: stop["longitude"]?.toString() ?? "-",
          isStartingStop: widget.isStartingStop,
          isbackneeded: widget.isbackneeded,
        );
      },
    );
  }
}
