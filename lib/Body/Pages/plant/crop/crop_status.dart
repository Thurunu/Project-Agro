import 'package:flutter/material.dart';

Widget cropStatus(Widget icon, String title, String date, String ago) {
  return Container(
    height: 60,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromRGBO(238, 247, 240, 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Horizontally align children at the ends
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // Align date and ago to the right
            children: [
              Text(date,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(ago,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
            ],
          ),
        ),
      ],
    ),
  );
}
