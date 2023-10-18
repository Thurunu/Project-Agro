import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/plant/custom_dropdown_menu.dart';
import 'package:project_algora_2/Body/Pages/plant/plant_adding_form.dart';

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
                  Text("All your crops appear here.",style: TextStyle(fontSize: 14,letterSpacing: 0.5, fontWeight: FontWeight.w500),),
                  Text("You haven't added any crops yet.",style: TextStyle(fontSize: 14,letterSpacing: 0.5, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
          Positioned(
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
          ),
        ],
      ),
    );
  }
}
