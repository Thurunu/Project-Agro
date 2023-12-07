import 'package:flutter/material.dart';
import 'package:project_algora_2/widgets/background_circle.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        const Positioned(
            right: 0,
        bottom: 0,
            child: BackgroundCircle(height: 150, width: 150)),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gif/People taking care of plants.gif'),
              fit: BoxFit.contain, // or adjust to your preference
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: screenHeight/3*2, right: 20, left: 20),
          child: const Text(
            'Get the most accurate soil measurement information with our IoT-based hardware.',
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.75), fontSize:16, fontWeight: FontWeight.w500 ), textAlign: TextAlign.center// Set text color to your preference
          ),
        ),
        const Positioned(
            left: 2,
        top: 0,
            child: BackgroundCircle(height: 150, width: 150)),
        const Positioned(
          top: 5,
            right: 8,
        bottom: 5,
            child: BackgroundCircle(height: 150, width: 150))
      ],
    );
  }

}
