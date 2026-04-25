import 'package:flutter/material.dart';

class TravelDateSelectionBlock extends StatefulWidget{
  const TravelDateSelectionBlock({super.key});

  @override
  State<TravelDateSelectionBlock> createState() => _TravelDateSelectionBlockState();
}

class _TravelDateSelectionBlockState extends State<TravelDateSelectionBlock> {

  DateTime? _selectedDate = DateTime.now();
  String _selectedType = "today";


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
          // horizontal line
          Container(
            width: double.infinity,
            height: 2,
            color: Theme.of(context).dividerColor,
          ),

          //travel date title and select calendar button too
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // travel date title with calendar icon
                  children: [

                    // travel date title with calendar icon
                    Icon(
                      Icons.calendar_month, 
                      color: Theme.of(context).colorScheme.onSurfaceVariant, 
                      size: 16,
                    ),

                    SizedBox(width: 2,),
                    Text("TRAVEL DATE", // travel date headding
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async{
                        setState(() {
                          _selectedType = "custom";
                        });
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
                    setState(() {
                      _selectedType = "today";
                      _selectedDate = DateTime.now();
                    });
                  }, 
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                   backgroundColor: 
                    WidgetStateProperty.all(
                      _selectedType == "today"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHigh
                    ),

                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                   shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10))),
                    ),
                  
                  child: Text("Today",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: _selectedType == "today"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                    letterSpacing: 0, 
                  ),
                  ),
                ),
              ),
              
              //tomorrow button
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _selectedType = "tomorrow";
                    _selectedDate = DateTime.now().add(const Duration(days: 1));
                    });
                  }, 

                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                   backgroundColor: 
                    WidgetStateProperty.all(
                      _selectedType == "tomorrow"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHigh
                    ),
                   padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                   shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10))),
                    ),
                  
                  child: Text("Tomorrow",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: _selectedType == "tomorrow"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                    letterSpacing: 0,
                  ),
                  ),
                ),
              ),
          
              // calendar icon button
              ElevatedButton(
                onPressed: ()async{
                  setState(() {
                    _selectedType = "custom";
                  });
                  await pickDate();
                }, 
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                 backgroundColor: 
                    WidgetStateProperty.all(
                      _selectedType == "custom"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHigh
                    ),

                 padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    ),
                  
                 shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10))),
                  ),
                child: Icon(
                  Icons.calendar_month, 
                  color: _selectedType == "custom"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}