import 'package:flutter/material.dart';


class TripLocationSelectionPage extends StatefulWidget {
  const TripLocationSelectionPage({super.key});

  @override
  State<TripLocationSelectionPage> createState() =>
      _TripLocationSelectionPageState();
}

class _TripLocationSelectionPageState extends State<TripLocationSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140), // taller AppBar
        child: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          elevation: 4,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              left: 16, right :10, top : 40
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FROM TextField
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      
                      hintText: "From",
                      hintStyle: TextStyle(
                        color: Colors.grey,
    
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                // TO TextField
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      
                      hintText: "To",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
