import 'package:flutter/material.dart';
import 'package:planner_demo/utils/glowing_dot.dart';
import 'package:planner_demo/utils/routes.dart';

class TripDatails extends StatefulWidget {


  TripDatails({super.key});

  @override
  State<TripDatails> createState() => _TripDatailsState();
}

class _TripDatailsState extends State<TripDatails> {
  Map<String, int> intcolors = {
  'blue': 0xFF0000FF,
  'red': 0xFFFF0000,
  'green': 0xFF00FF00
};

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400,
          height: 150,
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //from text field
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                                        
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black),
                              )
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, AppRoutes.locationsSelection);
                            },
                            child:Row(
                                    
                              children: [
                                        
                                GlowingDot(dotColor: 0xFF00FF00),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "From",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        ),
                      ),


                       //to textfield
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                                        
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black),
                              )
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, AppRoutes.locationsSelection);
                            },
                            child:Row(
                                    
                              children: [
                                        
                                GlowingDot(dotColor: 0xFFFF0000),

                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "To",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 45, left: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(60)
                      ),
                      child: IconButton(
                        onPressed: (){}, 
                        icon: Icon(
                          Icons.swap_vert,
                          size: 30,
                          color: Colors.white,
                        ),
                        
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      
      
    );
  }
}