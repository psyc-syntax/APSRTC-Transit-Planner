import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/trips/saved_connections_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';


class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      loadSavedTrips(ref);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top : true,
        left : true,
        right : true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const TopTitle(isbackNeeded: false, title: "Saved Trips",),
              const SizedBox(height: 16,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      
                      const SavedConnectionsBlock(),
                  
                      SizedBox(height: 100,),

                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
