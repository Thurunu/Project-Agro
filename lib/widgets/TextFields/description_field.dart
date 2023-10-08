import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  final storage = FirebaseStorage.instance;
  late String imageUrl;
  bool isLoading = true; // Track whether the image is still loading.

  @override
  void initState() {
    super.initState();
    // Set up the initial value of imageUrl to an empty string.
    imageUrl = "";
    // Retrieve the image from Firebase Storage.
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    try {
      // Get the image from Firebase Storage.
      final ref = storage.ref().child("crops/${widget.cropName}.webp");
      final imageRef = await ref.getDownloadURL();

      // Use http client to read the image data.
      final response = await http.get(Uri.parse(imageRef));
      if (response.statusCode == 200) {
        setState(() {
          imageUrl = imageRef; // Store the image URL directly.
          // print('*********************************');
          // print(imageUrl);
          isLoading = false; // Set loading to false when the image is loaded.
        });
      } else {
        print("Error ${response.statusCode}");
        // Handle the error appropriately (e.g., show a placeholder image).
      }
    } catch (e) {
      print("Error fetching image: $e");
      // Handle any exceptions that may occur.
    }
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
                        style: const TextStyle(
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
            child:
                isLoading
                    ? SizedBox(
                  width: 200,
                  height: 1.0,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade500,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade500),
                    value: 0.5,
                    minHeight: 0.5,
                  ),
                ) : // Show a loading indicator while the image is loading.
                Container(
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
