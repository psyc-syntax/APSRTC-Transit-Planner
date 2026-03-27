import 'package:flutter/material.dart';

class StopBasicDetailsCard extends StatelessWidget{
  const StopBasicDetailsCard({
    super.key,
    required this.stopName,
    required this.district,
    required this.pincode,
    required this.address,
  });

  final String stopName;
  final String district;
  final String pincode;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                      size: 42,
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
                      fontSize: 18,
                    ),
                  ),
          
                  Text(
                    address.length > 30
                     ?address.substring(0,30)
                     :address,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
          
                  Row(
                    children: [
                      Text("$district- ", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                    ),
                      Text(pincode, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                      ),
                    ],
                  ),
                  
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
               height: 2,
               width: double.infinity,
               color: Theme.of(context).dividerColor,
             )
        ],
      ),
    );
  }
}