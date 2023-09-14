import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/widgets/description_field.dart';

class GetCropDetails extends StatelessWidget {
  final String documentID;
  final double width;
  GetCropDetails({
    super.key,
    required this.documentID,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference cropDetails =
        FirebaseFirestore.instance.collection('crop_details');
    return FutureBuilder<DocumentSnapshot>(
      future: cropDetails.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String name = data['name'] ??
              ''; // Use an empty string as a default value if 'name' is null
          String description = data['description'] ?? '';

          return DescriptionField(
            currentWidth: width,
            cropName: name,
            cropDetails: description,
          );
        }

        return const Column(
          children: [
            Expanded(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }),
    );
  }
}
