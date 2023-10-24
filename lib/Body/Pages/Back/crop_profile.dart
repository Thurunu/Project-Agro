import 'package:flutter/material.dart';

class CropProfile extends StatelessWidget {
  const CropProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
            width: screenWidth - 20,
            height: screenHeight / 3,
          ),
          Container(
            width: screenWidth - 60,
            height: screenHeight / 4,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(172, 213, 178, 0.7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 75),
              child: Column(
                children: [
                  Text(
                    "Crop Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'Description',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     height: 1.5,
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Notification :"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 230,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                width: screenWidth / 3.5,
                height: screenHeight / 3.5,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/test/Tomato.png'),
                      fit: BoxFit.contain),
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
