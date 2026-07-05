import 'package:flutter/material.dart';

class TransitEndchildCard extends StatelessWidget {
  const TransitEndchildCard({
    super.key,
    required this.timeString, 
    required this.title, 
    required this.subtitle
  });

  final String title;
  final String subtitle;
  final String timeString;

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    // return Card(
    //   elevation: 0,
    //   margin: EdgeInsets.zero,
    //   color: theme.colorScheme.secondary.withOpacity(0.2),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     side: BorderSide(color: theme.colorScheme.secondary.withOpacity(0.8)),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               style: theme.textTheme.titleMedium?.copyWith(
    //                 fontSize: 14,
                   
    //               ),
    //             ),
    //             const SizedBox(height: 2),
    //             Text(
    //               subtitle,
    //               style: theme.textTheme.titleMedium?.copyWith(
    //                 fontSize: 12
    //               ),
    //             ),
    //           ],
    //         ),
    //         Text(
    //           timeString,
    //           style: theme.textTheme.labelMedium?.copyWith(
    //             fontWeight: FontWeight.bold,
    //             color: theme.colorScheme.onSecondaryContainer,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        )
      ),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                ),),
                Text(subtitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
