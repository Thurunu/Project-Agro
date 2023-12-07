import 'package:flutter/material.dart';

class CropProfile extends StatefulWidget {
  DateTime date;
  String name;
  String imageUrl;
  String docId;
  String dateStatus;
   CropProfile({super.key,required this.name,required this.date, required this.imageUrl, required this.docId,required this.dateStatus});

  @override
  State<CropProfile> createState() => _CropProfileState();
}

class _CropProfileState extends State<CropProfile> {
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
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 75),
              child: Column(
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(widget.dateStatus,style: TextStyle(color: Colors.black),), // Display the date status
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
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
                color: Colors.green.shade50,
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
