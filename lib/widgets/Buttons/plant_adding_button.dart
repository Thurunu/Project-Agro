import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Body/Pages/plant/plant_adding_form.dart';

class PlantAddingButton extends StatelessWidget {
  const PlantAddingButton({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: screenHeight *
          0.65, // Position the second text below the first text
      left: 0, // Position the second text at the left
      right: 0, // Position the second text at the right
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.04, right: screenWidth * 0.04),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context) .push(
                MaterialPageRoute(builder: (context){
                  return PlantAddingForm();
                })
            );
          },
          child: Container(
            height: screenHeight * 0.15,
            width: screenWidth - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade700,
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0,5),
                ),
              ],
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(CupertinoIcons.plus, size: 80),
                  Text(
                    "Grow your crops with us, "
                        "we'll guide you\n to grow your crops health",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}