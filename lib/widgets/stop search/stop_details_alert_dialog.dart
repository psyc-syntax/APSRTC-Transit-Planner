import 'package\:flutter/material.dart';

class StopDetailsAlertDialog extends StatelessWidget {
  const StopDetailsAlertDialog({
    super.key,
    required this.placeName,
    required this.placeId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pincode,
    required this.district,
  });

  final String placeName;
  final String placeId;
  final String? pincode;
  final String? district;
  final String? address;
  final String? latitude;
  final String? longitude;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
  actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
  title: Text(
    placeName,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 18),
  ),

      
      content: Column(
        mainAxisSize: MainAxisSize.min, // <-- Important
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _detailRow("Address", address ?? "-", context),

          _detailRow("District", district ?? "-", context),
          
          _detailRow("Pincode", pincode ?? "-", context),

          

          

          _detailRow("Latitude", latitude ?? "-", context),
          _detailRow("Longitude", longitude ?? "-", context),
          _detailRow("Place ID", placeId, context),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  Widget _detailRow(String title, String value, BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          children: [
            TextSpan(
              text: "$title : ",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
                fontSize: 12
              ),
            ),
            TextSpan(
              text: value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12
              ),
            ),
          ],
        ),
      ),
    );
  }
}
