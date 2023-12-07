import 'package:flutter/material.dart';

import '../widgets/background_circle.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

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
              image: AssetImage('assets/gif/planting tree.gif'),
              fit: BoxFit.contain, // or adjust to your preference
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
