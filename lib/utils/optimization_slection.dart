import 'package:flutter/material.dart';

class OptimizationSlection extends StatefulWidget {
  const OptimizationSlection({super.key});

  @override
  State<OptimizationSlection> createState() => _OptimizationSlectionState();
}

class _OptimizationSlectionState extends State<OptimizationSlection> {

  bool fastestmodeselected = false;
  bool costmodeselected = false;
  bool distancemodeselected = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // headding
          Column(
            children: [
              Text(
                "OPTMIZE FOR",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          
          //gap between
          SizedBox(
            height: 8
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    fastestmodeselected = !fastestmodeselected;
                    costmodeselected = false;
                    distancemodeselected = false;
                  });

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: fastestmodeselected? Colors.blue[900]: Colors.grey[200],
                elevation: fastestmodeselected ? 2 : 0,
                fixedSize: Size(110, 70),
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top : 12, bottom: 5),
                    child: Icon(
                      Icons.watch_later,
                      size: 24,
                      color: fastestmodeselected? Colors.white : Colors.black
                      ),
                  ),
                  Text(
                    "fastest",
                    style: TextStyle(
                      color: fastestmodeselected? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )
              ),

              // gap between each button
              SizedBox(width: 10,),


              //costmode button
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    costmodeselected = !costmodeselected;
                    fastestmodeselected = false;
                    distancemodeselected = false;
                  });

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: costmodeselected? Colors.blue[900]: Colors.grey[200],
                elevation: costmodeselected ? 2 : 0,
                fixedSize: Size(110, 70),
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top : 12, bottom: 5),
                    child: Icon(
                      Icons.currency_rupee,
                      size: 24,
                      color: costmodeselected? Colors.white : Colors.black
                      ),
                  ),
                  Text(
                    "cheepest",
                    style: TextStyle(
                      color: costmodeselected? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )
              ),

              //gap between button
              SizedBox(width: 10),

              //shortest mode button
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    distancemodeselected = !distancemodeselected;
                    fastestmodeselected = false;
                    costmodeselected = false;
                  });

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: distancemodeselected? Colors.blue[900]: Colors.grey[200],
                elevation: distancemodeselected ? 2 : 0,
                fixedSize: Size(110, 70),
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top : 12, bottom: 5),
                    child: Icon(
                      Icons.map,
                      size: 24,
                      color: distancemodeselected? Colors.white : Colors.black
                      ),
                  ),
                  Text(
                    "shortest",
                    style: TextStyle(
                      color: distancemodeselected? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )
              ),


            ],
          )

            ],
          )
    );
  }
}