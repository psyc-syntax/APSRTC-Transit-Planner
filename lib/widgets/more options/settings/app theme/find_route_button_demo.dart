import 'package:flutter/material.dart';

class FindOptimalRouteButtonDemo extends StatelessWidget {
  const FindOptimalRouteButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.primary.withAlpha(75),
          //     blurRadius: 16.0,
          //     offset: Offset(0, 8),
          //   ),
          // ],
        ),
        child: ElevatedButton(
          onPressed: () {},

          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(30),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Plan Smart Trip", style: TextStyle(
              fontSize: 10,
              overflow: TextOverflow.ellipsis
            ))],
          ),
        ),
      ),
    );
  }
}
