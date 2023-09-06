import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final String cropName;
   const DescriptionField({
    super.key,
    required this.currentWidth,
    required this.cropName,
  });

  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: currentWidth,
      height: 150,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 30),
            child: Container(
              height: 150,
              width: 300,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(172, 213, 178, 0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(180),
                ),
              ),
              child:  Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 75),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        cropName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Can be grown in almost all agroclimatic zones in Sri Lanka except up country wet zone.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 230,
            right: 5,
            bottom: 1.5,
            top: 1.5,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/test/Tomato.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}