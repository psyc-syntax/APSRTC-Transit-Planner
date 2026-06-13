import 'package:flutter/material.dart';

class NotificationScreenQuestionParamsContainer extends StatelessWidget {
  const NotificationScreenQuestionParamsContainer({
    super.key,
    required this.icon,
    required this.param1,
    required this.param2,
    required this.paramdetail1,
    required this.paramdetail2,
    required this.isSelected,
    required this.onOptionSelected,
    required this.index,
  });

  final IconData icon;
  final String param1;
  final String param2;
  final String paramdetail1;
  final String paramdetail2; 
  final bool isSelected;
  final void Function(int) onOptionSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onOptionSelected(index), // Assuming 1 is the index for this option
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
              width: 1.5,
            )
          ),
        
          child: Padding(
            padding: isSelected 
            ? const EdgeInsets.symmetric(vertical: 20, horizontal: 2) 
            : const EdgeInsets.symmetric(vertical: 16, horizontal: 2),

            child: Column(
              children: [
                Icon(icon, size: 32),
        
                const SizedBox(height: 4),
        
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
        
                const SizedBox(height: 10),
        
                Text(
                  param1,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
        
                Text(
                  param2,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
        
                const SizedBox(height: 10),
        
                Text(
                  paramdetail1,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    letterSpacing: 0.5,
                    fontSize: 12.5,
                  ),
                  textAlign: TextAlign.center,
                ),
        
                Text(
                  paramdetail2,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    letterSpacing: 0.5,
                    fontSize: 12.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
