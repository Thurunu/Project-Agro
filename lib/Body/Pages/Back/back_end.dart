import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

class BackEnd {
  String cropName = 'default'; // Initialize with an empty string
  bool status = false; // Initialize with an empty string
  DateTime date = DateTime.now(); // Initialize with the current date and time
  bool iot = false; // Initialize with an empty string
  String imageUrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');
  final storage = FirebaseStorage.instance;


  //get user id
  String _getCurrentUserUid() {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    return 'error';
  }

  //validate collection
  Future<bool> isSecondSubCollectionEmpty() async {
    String documentId = _getCurrentUserUid();
    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        CollectionReference subCollection = documentSnapshot.reference.collection('crops');
        QuerySnapshot subCollectionSnapshot = await subCollection.get();

        // Check if the second subcollection is empty
        return subCollectionSnapshot.docs.isEmpty;
      } else {
        print("Document with ID $documentId does not exist.");
        return true; // Treat it as empty if the main document doesn't exist
      }
    } catch (e) {
      print("Error accessing data in isSecondSubcollectionEmpty: $e");
      return true; // Treat it as empty in case of an error
    }
  }

  //check subCollection length
  Future<int> getLength() async {
    String documentId = _getCurrentUserUid(); // Make sure this function returns the correct UID.
    int dataLength = 0;
    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();
      if (documentSnapshot.exists) {
        CollectionReference subCollection = documentSnapshot.reference.collection('crops');
        QuerySnapshot querySnapshot = await subCollection.get();
        dataLength = querySnapshot.size;
      } else {
        print("Document with ID $documentId does not exist.");
      }
    } catch (e) {
      print("Error accessing data: $e");
    }
    return dataLength;
  }

//get image urls
  Future<String> getImageUrl(String cropName) async {
    try {
      // Get the image from Firebase Storage.
      final ref = storage.ref().child("crops/$cropName.webp");
      final imageRef = await ref.getDownloadURL();

      // Use http client to read the image data.
      final response = await get(Uri.parse(imageRef));
      if (response.statusCode == 200) {

          imageUrl = imageRef; // Store the image URL directly.
          // print('*********************************');
          // print(imageUrl);
          return imageUrl;

      } else {
        print("Error ${response.statusCode}");
        // Handle the error appropriately (e.g., show a placeholder image).
      }
    } catch (e) {
      print("Error fetching image: $e");
      // Handle any exceptions that may occur.
    }
    return imageUrl;
  }


//print data on subcollection
  Future<Map<String, dynamic>> getCropData() async {
    String documentId = _getCurrentUserUid();
    String name;
    DateTime day;
    Map<String, dynamic> result = {};

    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        // Access the specific subcollection
        CollectionReference subCollection = documentSnapshot.reference.collection('crops');

        QuerySnapshot subCollectionSnapshot = await subCollection.get();
        List<Map<String, dynamic>> cropsData = [];

        subCollectionSnapshot.docs.forEach((doc) {
          name = doc['name'] ?? '';
          day = doc['planted_data'] != null
              ? (doc['planted_data'] as Timestamp).toDate()
              : DateTime.now(); // Assuming 'planted_data' is a Timestamp field

          // Add the subcollection document ID to the data
          cropsData.add({
            'documentId': doc.id, // Add the document ID here
            'name': name,
            'planted_data': day,
          });
        });

        result['Crops'] = cropsData;
        // print('\n\ncrops data\n\n');
        // print(cropsData);
      }
    } catch (e) {
      print("Error in getCropData: $e");
    }

    return result;
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
  Future<void> addDataToSubcollection(String docId) async {
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
    String subDocid = docId;
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
