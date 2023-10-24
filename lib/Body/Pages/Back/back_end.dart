import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackEnd {
  String cropName = ''; // Initialize with an empty string
  bool status = false; // Initialize with an empty string
  DateTime date = DateTime.now(); // Initialize with the current date and time
  bool iot = false; // Initialize with an empty string

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');

  String _getCurrentUserUid() {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    return 'error';
  }

//print data on subcollection
  Future<void> printSpecificUserDataAndSubcollection(
      String subcollectionName) async {
    String documentId = _getCurrentUserUid();
    try {
      DocumentSnapshot documentSnapshot =
          await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        print("Document ID: ${documentSnapshot.id}");
        print("Data: ${documentSnapshot.data()}");

        // Access the specific subcollection
        CollectionReference subCollection =
            documentSnapshot.reference.collection(subcollectionName);

        QuerySnapshot subCollectionSnapshot = await subCollection.get();
        for (QueryDocumentSnapshot subDoc in subCollectionSnapshot.docs) {
          print("Subdocument ID: ${subDoc.id}");
          print("Subdocument Data: ${subDoc.data()}");
        }
      } else {
        print("Document with ID $documentId does not exist.");
      }
    } catch (e) {
      print("Error accessing data: $e");
    }
  }
  //set crop name
  void setCropName(String name) {
    cropName = name;
    print(cropName);
  }

//set planted or not
  void setStatus(bool status) {
    this.status = status;
    print(status);
  }

//set date
  void setDate(DateTime date) {
    this.date = date;
    print(date);
  }

//set iot status
  void setIOT(bool iot) {
    this.iot = iot;
    print(iot);
  }

// Add data to a subcollection within a specific document
  Future<void> addDataToSubcollection() async {
    Map<String, dynamic> data = {
      'name': cropName,
      'planted_data': date,
      'iot': iot,
      'status': status,
    };

    String documentId = _getCurrentUserUid();

    if (documentId == 'error') {
      print("Error: User is not authenticated.");
      return;
    }

    print(documentId);
    String subcollectionName = 'crops';
    // String subDocid = data['name'].toString();
    String subDocid = 'tomato12356';
    try {
      // Access the specific subcollection
      CollectionReference subCollection =
      userCollection.doc(documentId).collection(subcollectionName);

      // Add data to the subcollection
      await subCollection.doc(subDocid).set(data);

      print("Data added to subcollection: $documentId");
    } catch (e) {
      print("Error adding data to subcollection: $e");
    }
  }


}
