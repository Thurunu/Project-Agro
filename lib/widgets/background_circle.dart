 import 'package:flutter/material.dart';

class BackgroundCircle extends StatelessWidget {
  final double height;
  final double width;
   const BackgroundCircle({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(52, 168, 83, 0.25),
            blurRadius: 300.0,
            spreadRadius: 75.0,
          ),
        ],
      ),
    );
  }
}