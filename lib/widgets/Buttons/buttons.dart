import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  String labelText;
  IconData iconData;
   Buttons({super.key, required this.labelText, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.green.withOpacity(0.7), // Border color with opacity
              width: 2, // Border width
            ),
          ),
          child: Icon(iconData),
        ),
        SizedBox(width: 20), // Add spacing between the icon and text
        Text(labelText, style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
      ],
    );

  }
}

