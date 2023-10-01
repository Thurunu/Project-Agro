import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Widget BuildCropList(String zone) {
  return FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance.collection('agri_zones').doc(zone).get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, you can return a loading indicator.
        return CircularProgressIndicator(); // Replace with your desired loading widget.
      } else if (snapshot.hasError) {
        // If an error occurs, you can return an error message or widget.
        return Text("Error: ${snapshot.error}");
      } else if (snapshot.hasData) {
        // If data is available, you can use it to build your UI.
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        String crops = data['crops'] ?? '';

        List<String> cropsList = crops.split(',');
        print('**************building crop list******************');
        print(cropsList);

        return ListView.builder(
          itemCount: cropsList.length,
          itemBuilder: (context, index) {
            // return GetCropDetails(
            //   documentID: docIDs[index],
            //   width: currentWidth,
            // );
          },
        );
      } else {
        // If none of the above conditions are met, you can return a fallback widget.
        return Text("No data available.");
      }
    },
  );
}
