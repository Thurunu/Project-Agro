import 'package:flutter/material.dart';

import '../widgets/background_circle.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              image: AssetImage('assets/gif/Collection.gif'),
              fit: BoxFit.contain, // or adjust to your preference
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: screenHeight/3*1.1, right: 20, left: 20),
          child: Center(
            child: const Text(
                'We know the best crops suited for your area.',
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.75), fontSize:16, fontWeight: FontWeight.w500 ), textAlign: TextAlign.center// Set text color to your preference
            ),
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
