import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class StopBasicDetailsCard extends ConsumerWidget{
  const StopBasicDetailsCard({
    super.key,
    required this.stopName,
    required this.district,
    required this.pincode,
    required this.address,
    required this.placeId,
    required this.isStartingStop,
    required this.isbackneeded,

  });

  final String stopName;
  final String district;
  final String pincode;
  final String address;
  final String placeId;
  final bool isStartingStop;
  final bool isbackneeded;

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () {
          if(isbackneeded){
            if(isStartingStop){
              ref.read(startingPlaceIdProvider.notifier).state = placeId.trim();
              ref.read(startingPlaceNameProvider.notifier).state = stopName;  
              ref.read(isstartingPlaceSelectedProvider.notifier).state = true;
              print("Updated startingPlaceIdProvider: ${ref.read(startingPlaceIdProvider)}");
            }
            else{
              ref.read(destinationPlaceIdProvider.notifier).state = placeId.trim();
              ref.read(destinationPlaceNameProvider.notifier).state = stopName;
              ref.read(isdestinationPlaceSelectedProvider.notifier).state = true;
              print("Updated destinationPlaceIdProvider: ${ref.read(destinationPlaceIdProvider)}");
            }
            
            
            Navigator.pop(context);
          }
          else{
            (){};
            // Handle the case when back navigation is not needed
            // For example, you might want to navigate to a different screen or show a message
          }
        },
        child: Column(
          children: [
            Row(
                children: [
                  // ButtonWithIcon(
                  //   icon: Icons.business, 
                  //   elevation: 0.1,
                  //   iconsize: 42, 
                  //   fillColor: Theme.of(context).colorScheme.surface,
                  //   iconColor: Theme.of(context).dividerColor,
                  // ),
        
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 2,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.business, 
                        color: Theme.of(context).dividerColor,
                        size: 32,
                      ),
                    ),
                  ),
        
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        stopName.length> 22
                          ?stopName.substring(0,22)
                          :stopName, 
                          
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 16,
                      ),
                    ),
            
                    Text(
                      address.length > 30
                       ?address.substring(0,30)
                       :address,
        
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 12,
                        letterSpacing: 0,
                      ),
                    ),
            
                    Row(
                      children: [
                        Text("$district- ", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 12,
                        letterSpacing: 0,
                      ),
                      ),
                        Text(pincode, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 12,
                        letterSpacing: 0,
                      ),
                        ),
                      ],
                    ),
                    
                    ],
                  )
                ],
              ),
              SizedBox(height: 6,),
              Container(
                 height: 2,
                 width: double.infinity,
                 color: Theme.of(context).dividerColor,
               )
          ],
        ),
      ),
    );
  }
}