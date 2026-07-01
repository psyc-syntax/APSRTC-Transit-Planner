import 'package:flutter/material.dart';

class RouteResultsTripParamContainer extends StatelessWidget{
  const RouteResultsTripParamContainer({
    super.key,
    required this.param,
    required this.paramdetail,
  });

  final String param;
  final String paramdetail;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          border: Border.all(
            color: Theme.of(context).dividerColor,
          )
      
        ),
      
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
          child: Column(
            children: [
              Text(
                param,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14
                ),
              ),
          
              Text(
                paramdetail,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}