import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/description_field.dart';

class GetCropDetails extends StatefulWidget {
  double screenWidth;
  String documentID;

  GetCropDetails({
    required this.screenWidth,
    required this.documentID,
  });

  _GetCropDetailsState createState() => _GetCropDetailsState();
}

class _GetCropDetailsState extends State<GetCropDetails> {
  final String collectionID = 'agri_zones';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('agri_zones')
          .doc(widget.documentID)
          .collection('crop')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or a loading indicator
        }

        // Process the data from the snapshot here
        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        // Print the document IDs
        for (QueryDocumentSnapshot document in documents) {
          print('Document ID: ${document.id}');
        }
        final List<String> name =
            documents.map((doc) => doc['name'] as String).toList();
        final List<String> description =
            documents.map((doc) => doc['description'] as String).toList();

        print(description);
        print(name);

        return ListView.builder(
          itemCount: documents.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DescriptionField(
              currentWidth: widget.screenWidth,
              cropName: name[index],
              cropDetails: description[index],
            );
          },
        );
      },
    );
  }
}
