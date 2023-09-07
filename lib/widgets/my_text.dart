import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color; // Added color parameter
  final FontWeight fontWeight; // Added fontWeight parameter

  const MyText(
  {
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color, // Set font color
        fontWeight: fontWeight, // Set font weight
      ),
    );
  }
}
