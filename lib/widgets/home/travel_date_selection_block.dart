import 'package:flutter/material.dart';

class TravelDateSelectionBlock extends StatefulWidget{
  const TravelDateSelectionBlock({super.key});

  @override
  State<TravelDateSelectionBlock> createState() => _TravelDateSelectionBlockState();
}

class _TravelDateSelectionBlockState extends State<TravelDateSelectionBlock> {

  DateTime? _selectedDate = DateTime.now();

  Future<void> pickDate() async{
      DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2050),
    );

    if(date != null){
      _selectedDate = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 2,
            color: const Color(0xFFE2E8F0),
          ),

          //travel date title and select calendar button too
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: Colors.black54, size: 16,),
                    SizedBox(width: 2,),
                    Text("TRAVEL DATE", // travel date headding
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black54 ,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async{
                          await pickDate();
                        },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Select Calendar", // select calendar button 
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Text(" >")
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //today button
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    _selectedDate = DateTime.now();
                  }, 
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                   backgroundColor: WidgetStateProperty.all(Colors.white70),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                   shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10))),
                    ),
                  
                  child: Text("Today",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    color: Colors.black54,
                    letterSpacing: 0, 
                  ),
                  ),
                ),
              ),
              
              //tomorrow button
              Container(
                child: ElevatedButton(
                  
                  onPressed: (){
                    _selectedDate = DateTime.now().add(const Duration(days: 1));
                  }, 

                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                   backgroundColor: WidgetStateProperty.all(Colors.white70),
                   padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                   shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10))),
                    ),
                  
                  child: Text("Tomorrow",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    color: Colors.black54,
                    letterSpacing: 0,
                  ),
                  ),
                ),
              ),
          
              // calendar icon button
              ElevatedButton(
                onPressed: ()async{
                  await pickDate();
                }, 
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                 backgroundColor: WidgetStateProperty.all(Colors.white70),

                 padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    ),
                  
                 shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10))),
                  ),
                child: Icon(Icons.calendar_month, color: Colors.black54,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}