import 'package:flutter/material.dart';

class FindingBestRouteButton extends StatelessWidget {
  const FindingBestRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(400, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 28, color: Colors.white,),
          SizedBox(width: 10,),
          Text(
            "Find Best Route",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            ),
        ],
      ),
     );
  }
}