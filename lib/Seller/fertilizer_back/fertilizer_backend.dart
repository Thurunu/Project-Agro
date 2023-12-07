import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FertilizerBackend {
  String fertilizerName = 'default';
  double price = 0.0;
  int quantity = 0;
  int nitrogen = 0;
  int phosphorus = 0;
  int potassium = 0;
  String? selectedImage;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');
  final storageRef = FirebaseStorage.instance.ref();


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
    print(documentId);

    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        CollectionReference subCollection = documentSnapshot.reference.collection('fertilizers');
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


// Add data to a subcollection within a specific document
  Future<void> addDataToSubCollection(String docId) async {
    Map<String, dynamic> data = {
      'fertilizer_name': fertilizerName,
      'price': price,
      'quantity': quantity,
      'nitrogen': nitrogen,
      'phosphorus': phosphorus,
      'potassium': potassium,
    };

    String documentId = _getCurrentUserUid();

    if (documentId == 'error') {
      print("Error: User is not authenticated.");
      return;
    }

    print(documentId);
    String collectionName = 'fertilizers';
    // String subDocid = data['name'].toString();
    String subDocid = docId;
    try {
      // Access the specific subcollection
      CollectionReference subCollection =
      userCollection.doc(documentId).collection(collectionName);

      // Add data to the subcollection
      await subCollection.doc(subDocid).set(data);

      print("Data added to subcollection: $documentId");
    } catch (e) {
      print("Error adding data to subcollection: $e");
    }
  }

  //upload image
  Future<void> uploadImageToFirebase() async {
    String currentUser = _getCurrentUserUid();
    if (fertilizerName == 'default' || currentUser == 'error') {
      print("Error: You Should Add Fertilizer First");

      return;
    }

    try {
      // Generate a unique ID for the image file
      String imageId = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath = 'fertilizers/$currentUser/$fertilizerName$imageId.jpg';
      final File copy = File(selectedImage!);



      // Upload the image to Firebase Storage
      await storageRef.child(imagePath).putFile(copy);

      // Set the uploaded image address in the selectedImage variable
      setImageAddress(imagePath);

      print("Image uploaded successfully: $imagePath");
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
    }
  }


  //set image address
  void setImageAddress(String address){
    selectedImage = address;
    print(selectedImage);
  }

  //set fertilizer name
  void setFertilizerName(String name) {
    fertilizerName = name;
    print(name);
  }

  //set nitrogen level
  void setNitrogen(int num) {
    nitrogen = num;
    print(num);
  }

  //set potassium level
  void setPotassium(int num) {
    potassium = num;
    print(num);
  }

  //set phosphorus level
  void setPhosphorus(int num) {
    phosphorus = num;
    print(num);
  }

  //set price
  void setPrice(double price) {
    price = price;
    print(price);
  }

  //set quantity
  void setQuantity(int num) {
    quantity = num;
    print(quantity);
  }

  //set image data
}
