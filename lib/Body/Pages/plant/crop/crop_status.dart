import 'package:flutter/material.dart';

Widget cropStatus(IconData icon, String title, String date, String ago) {
  return Row(
    children: [
      Icon(icon),
      const SizedBox(width: 8), // Add spacing between the icon and text
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(width: 200,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(date),
          Text(ago),
        ],
      ),
    ],
  );
}
