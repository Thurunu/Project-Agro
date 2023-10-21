import 'package:flutter/material.dart';

Widget recommendations(
    String topic, String description, double screenHeight, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    child: Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.2,
      decoration: BoxDecoration(
        color: Color.fromRGBO(143, 6, 248, 0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.4),
            // offset: Offset(-2, -4),
            blurRadius: 2.5,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              topic,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,

                overflow:
                    TextOverflow.ellipsis, // Handle overflow with ellipsis
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
