import 'package:flutter/material.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550, // Set the height to accommodate the image and text
      width: 500,  // Set the width to match the image's width
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,  // Set the width of the image
            height: 300, // Set the height of the image
            child: Image.asset(
              "assets/gif/Code typing.gif",
              fit: BoxFit.contain,
              // Maintain the original aspect ratio
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0), // Adjust the padding as needed
            child: Text(
              "Apologies for any inconvenience. Our team is working hard to make your experience even better. Please hang tight, and we'll be back shortly!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black, // You can adjust text color as needed
                fontSize: 18.0, // You can adjust text size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
