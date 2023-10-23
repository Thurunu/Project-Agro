// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../read_data/get_crop_details.dart';
//
// class NewUser extends StatefulWidget {
//   double currentWidth;
//    NewUser(
//       {
//         super.key,
//         required this.currentWidth,
//       }
//       );
//
//   @override
//   State<NewUser> createState() => _NewUserState();
// }
//
// class _NewUserState extends State<NewUser> {
//   late String imageUrl;
//
//   //document IDs
//   final List<String> docIDs = [];
//
//   //getDoc IDs
//   Future<void> getDocIDs() async {
//     await FirebaseFirestore.instance.collection("crop_examples").get().then(
//           (snapshot) => snapshot.docs.forEach(
//             (document) {
//           docIDs.add(document.id);
//         },
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 50, left: 20),
//             child: Text(
//               "Popular crops in your area",
//               style: TextStyle(
//                 color: Color.fromRGBO(27, 94, 32, 0.9),
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           FutureBuilder(
//             future: getDocIDs(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 // Display a circular progress indicator while loading data
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 // Handle error case
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return FutureBuilder(
//                   // Add a Future.delayed here to delay the content display
//                   future:
//                   Future.delayed(const Duration(seconds: 3), () => true),
//                   builder: (context, delaySnapshot) {
//                     if (delaySnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       // Display a loading indicator during the 3-second delay
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else {
//                       // After the 3-second delay, display the GetCropDetails widgets
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 100),
//                         child: ListView.builder(
//                           itemCount: 4,
//                           itemBuilder: (context, index) {
//                             return GetCropDetails(
//                               documentID: docIDs[index],
//                               width: widget.currentWidth,
//                             );
//                           },
//                         ),
//                       );
//                     }
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
