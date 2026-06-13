// import 'package:flutter/material.dart';
// import 'package:planner_demo/screens/route_results_screen.dart';
// import 'package:planner_demo/widgets/notification%20screen/notification_screen%20_question_params_container.dart';

// class TripNotificationScreen extends StatefulWidget {
//   const TripNotificationScreen({super.key});

  

//   @override
//   State<TripNotificationScreen> createState() => _TripNotificationScreenState();
// }

// class _TripNotificationScreenState extends State<TripNotificationScreen> {

//   int _selectedOptionIndex = 1;

//   void onOptionSelected(int index){
//     setState(() {
//       _selectedOptionIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),

//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),

//           // Main layout
//           child: Column(
//             children: [
//               // 
//               // Scrollable top section
//               // 
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(width: double.infinity),

//                       // Title
//                       Text(
//                         "Your trip starts in",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineSmall
//                             ?.copyWith(
//                               fontSize: 26,
//                               height: 0.9,
//                             ),
//                         textAlign: TextAlign.center,
//                       ),

//                       // Time
//                       Text(
//                         "30 mins",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineSmall
//                             ?.copyWith(
//                               color:
//                                   Theme.of(context).colorScheme.primary,
//                               fontSize: 32,
//                             ),
//                       ),

//                       const SizedBox(height: 10),

//                       // Question
//                       Text(
//                         "Where are you now?",
//                         style:
//                             Theme.of(context).textTheme.headlineSmall,
//                       ),

//                       // Subtitle
//                       Text(
//                         "This helps us give you better guidence",
//                         style:
//                             Theme.of(context).textTheme.titleSmall,
//                       ),

//                       const SizedBox(height: 20),

//                       // 
//                       // Option cards
//                       // 
//                       Row(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                         // mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // 
//                           // CARD 1
//                           // 

//                           NotificationScreenQuestionParamsContainer(
//                             icon: Icons.person, 
//                             param1: "Iam at the", 
//                             param2: "Stop", 
//                             paramdetail1: "I have reached", 
//                             paramdetail2: "the stop",
//                             isSelected: _selectedOptionIndex == 1,
//                             onOptionSelected: onOptionSelected,
//                             index: 1,
//                           ),

//                           const SizedBox(width: 10),

//                           // 
//                           // CARD 2
//                           // 
//                           NotificationScreenQuestionParamsContainer(
//                             icon: Icons.pedal_bike, 
//                             param1: "on my way", 
//                             param2: "to Stop", 
//                             paramdetail1: "I am traveling", 
//                             paramdetail2: "to the stop",
//                             isSelected: _selectedOptionIndex == 2,
//                             onOptionSelected: onOptionSelected,
//                             index: 2,
//                           ),

//                           const SizedBox(width: 10), 

//                           // 
//                           // CARD 3
//                           // 

//                           NotificationScreenQuestionParamsContainer(
//                             icon: Icons.alarm, 
//                             param1: "I will be Late", 
//                             param2: " ", 
//                             paramdetail1: "I may not reach", 
//                             paramdetail2: "on time",
//                             isSelected: _selectedOptionIndex ==3,
//                             onOptionSelected: onOptionSelected,
//                             index: 3,
//                           ),

                          

                          
                          
//                         ],
//                       ),

//                       const SizedBox(height: 40),

//                       Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.surfaceContainerHighest,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Theme.of(context).dividerColor,
//                           )
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.warning_amber_outlined),
//                                   SizedBox(width: 10,),
//                                   Text("Smart Prediction",
//                                     style: Theme.of(context).textTheme.titleMedium,
//                                   ),
//                                 ],
//                               ),
                          
//                               SizedBox(height: 20,),

//                               Text("if you are on time, you will board on 08:00 AM and reach by 09:30 PM.",
//                               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                                 letterSpacing: 0.1,
//                               ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),

//               // 
//               // Fixed bottom button
//               // 
//               Padding(
//                 padding:
//                     const EdgeInsets.only(bottom: 16, top: 10),

//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .primary
//                             .withAlpha(75),
//                         blurRadius: 16.0,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),

//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (ctx) =>
//                               const RouteResultsScreen(),
//                         ),
//                       );
//                     },

//                     style: Theme.of(context)
//                         .elevatedButtonTheme
//                         .style
//                         ?.copyWith(
//                           shape: WidgetStatePropertyAll(
//                             RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(20),
//                             ),
//                           ),
//                         ),

//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 18,
//                       ),

//                       child: Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Confirm and continue",
//                             style: TextStyle(fontSize: 16),
//                           ),

//                           SizedBox(width: 4),

//                           Icon(
//                             Icons.bolt,
//                             size: 18,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }