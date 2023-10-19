import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CropField extends StatefulWidget {
  const CropField({super.key});

  @override
  State<CropField> createState() => _CropFieldState();
}

class _CropFieldState extends State<CropField> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Crop image
            Container(
              height: 200,
              color: Colors.black,
              // child: Image(
              //   image: NetworkImage(imageUrl),
              // ),
            ),
            // Soil moisture details
            Container(
              height: 200,
              color: Colors.yellow,
            ),
            Container(
              height: 25,
              color: Colors.green,
            ),
            // Crop status
            Container(
              height: 350,
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.red.shade300,
                  ),
                  Container(
                    height: 100,
                    color: Colors.red.shade600,
                  ),
                  Container(
                    height: 100,
                    color: Colors.red.shade900,
                  ),
                ],
              ),
            ),
            // Recommendations
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 350,
                width: 450,
                color: Colors.blue.shade800,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      color: Colors.purple.shade100,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade200,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade300,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade400,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade500,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade600,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade700,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade800,
                    ),
                    Container(
                      width: 50,
                      color: Colors.purple.shade900,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
