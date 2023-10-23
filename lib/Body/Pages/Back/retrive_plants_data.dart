// // import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class PlantData{
//
//   final storage = FirebaseStorage.instance;
//   late String imageUrl;
//   bool isLoading = true;
//   Future<void> getImageUrl() async {
//     try {
//       // Get the image from Firebase Storage.
//       final ref = storage.ref().child("crops/tomato.webp");
//       final imageRef = await ref.getDownloadURL();
//
//
//       // Use http client to read the image data.
//       final response = await http.get(Uri.parse(imageRef));
//       if (response.statusCode == 200) {
//         setState(() {
//           imageUrl = imageRef; // Store the image URL directly.
//           // print('*********************************');
//           // print(imageUrl);
//           isLoading = false; // Set loading to false when the image is loaded.
//         });
//       } else {
//         print("Error ${response.statusCode}");
//         // Handle the error appropriately (e.g., show a placeholder image).
//       }
//     } catch (e) {
//       print("Error fetching image: $e");
//       // Handle any exceptions that may occur.
//     }
//   }
// }