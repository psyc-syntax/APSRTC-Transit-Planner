
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';


final startingPlaceIdProvider = StateProvider<String>((ref) => "");
final startingPlaceNameProvider = StateProvider<String>((ref) => "Select starting point");
final destinationPlaceIdProvider = StateProvider<String>((ref) => "");
final destinationPlaceNameProvider = StateProvider<String>((ref) => "Select destination point");
final isstartingPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isdestinationPlaceSelectedProvider = StateProvider<bool>((ref) => false);

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0); 
