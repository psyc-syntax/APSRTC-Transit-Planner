import "package:flutter/material.dart";

class TripsTypeBar extends StatefulWidget {
  const TripsTypeBar({super.key});

  @override
  State<TripsTypeBar> createState() => _TripsTypeBarState();
}

class _TripsTypeBarState extends State<TripsTypeBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Recent", style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: selectedIndex == 0 ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant
                    ),),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == 0 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    width: double.infinity,
                    height: 3,
                    
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Saved", style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: selectedIndex == 1 ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == 1 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    width: double.infinity,
                    height: 3,
                    
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}