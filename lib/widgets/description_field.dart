import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {
  final String cropName;
  final String cropDetails;
  final double currentWidth;

  const DescriptionField({
    super.key,
    required this.currentWidth,
    required this.cropName,
    required this.cropDetails,

  });

  _DescriptionFieldState createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  final storage = FirebaseStorage.instance;
  late String imageUrl;

  void initState(){
    super.initState();
    //seting up initial value of image url to empty
    imageUrl = "";
    //retrive the iamge from firebase storage
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    //Get the image from firebase storage
    final ref = storage.ref().child("crops/${widget.cropName}.webp");

    final imageRef = await ref.getDownloadURL();
    setState(() {
      print(imageRef);
      imageUrl = imageRef.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: widget.currentWidth,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 75),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.cropName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.cropDetails,
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),

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