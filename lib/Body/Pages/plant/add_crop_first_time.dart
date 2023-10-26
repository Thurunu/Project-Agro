import 'package:flutter/material.dart';

import '../../../widgets/Buttons/plant_adding_button.dart';

class AddCropFirstTime extends StatefulWidget {
  const AddCropFirstTime({Key? key}) : super(key: key);

  @override
  _AddCropFirstTimeState createState() => _AddCropFirstTimeState();
}

class _AddCropFirstTimeState extends State<AddCropFirstTime> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 30, // Position the image at the top
            left: 0, // Position the image at the left
            child: Center(
              child: Image.asset(
                'assets/gif/Empty.gif',
                width: screenWidth * 0.9,
                height: screenHeight * 0.5,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.5, // Position the text below the image
            left: screenWidth * 0.2, // Position the text at the left
            right: screenWidth * 0.2, // Position the text at the right
            child: const Center(
              child: Column(
                children: [
                  Text(
                    "All your crops appear here.",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "You haven't added any crops yet.",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          PlantAddingButton(),
        ],
      ),
    );
  }
}
