import 'package:flutter/material.dart';


class TripNavLocationDetailsSingleParam extends StatelessWidget {
  const TripNavLocationDetailsSingleParam({
    super.key,
    required this.icon,
    required this.paramDetail,
    required this.title,
    required this.iconColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String paramDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor,
        ),

        const SizedBox(width: 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  letterSpacing: 0.1,
                ),
              ),

              Text(
                paramDetail,
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}