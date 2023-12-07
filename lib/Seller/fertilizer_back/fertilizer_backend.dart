import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

class FertilizerBackend {
  String fertilizerName = 'default';
  double price = 0.0;
  int quantity = 0;
  int nitrogen = 0;
  int phosphorus = 0;
  int potassium = 0;
  String? selectedImage;
  String imageUrl = '';


  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');
  final storageRef = FirebaseStorage.instance.ref();
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
      print("Error accessing data in is Second Sub collection Empty: $e");
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
        CollectionReference subCollection = documentSnapshot.reference.collection('fertilizers');
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
//get documents
  Future<List<Map<String, dynamic>>> getAllDocuments() async {
    String documentId = _getCurrentUserUid();
    List<Map<String, dynamic>> documents = [];

    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        CollectionReference subCollection = documentSnapshot.reference.collection('fertilizers');
        QuerySnapshot querySnapshot = await subCollection.get();

        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Convert each document to a Map and add it to the list
          documents.add(document.data() as Map<String, dynamic>);
        }
      } else {
        print("Document with ID $documentId does not exist.");
      }
    } catch (e) {
      print("Error accessing data: $e");
    }

    return documents;
  }

// Add data to a sub-collection within a specific document
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
    // String sub Doc id = data['name'].toString();
    String subDocId = docId;
    try {
      // Access the specific sub-collection
      CollectionReference subCollection =
      userCollection.doc(documentId).collection(collectionName);

      // Add data to the sub-collection
      await subCollection.doc(subDocId).set(data);

      print("Data added to sub-collection: $documentId");
    } catch (e) {
      print("Error adding data to sub-collection: $e");
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
      String imagePath = 'fertilizers/$currentUser/$fertilizerName.jpg';
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

  //get image urls
  Future<String> getImageUrl(String fertilizerName,String docID) async {
    try {
      print(fertilizerName+docID);
      // Get the image from Firebase Storage.
      final ref = storage.ref().child("fertilizers/$docID/$fertilizerName.jpg");
      final imageRef = await ref.getDownloadURL();

      // Use http client to read the image data.
      final response = await get(Uri.parse(imageRef));
      if (response.statusCode == 200) {

        imageUrl = imageRef; // Store the image URL directly.
        // print('*********************************');
        print(imageUrl);
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

  //print data on sub-collection
  Future<Map<String, dynamic>> getFertilizerData() async {
    String documentId = _getCurrentUserUid();
    String name;
    int nitrogen;
    int phosphorus;
    int potassium;
    double price;
    int quantity;
    Map<String, dynamic> result = {};

    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(documentId).get();

      if (documentSnapshot.exists) {
        // Access the specific sub - collection
        CollectionReference subCollection = documentSnapshot.reference.collection('fertilizers');

        QuerySnapshot subCollectionSnapshot = await subCollection.get();
        List<Map<String, dynamic>> fertilizerData = [];

        for (var doc in subCollectionSnapshot.docs) {
          name = doc['fertilizer_name'] ?? '';
          nitrogen = doc['nitrogen'] ?? 0;
          phosphorus = doc['phosphorus'] ?? 0;
          potassium = doc['potassium'] ?? 0;
          price = doc['price'] ?? 0.0;
          quantity = doc['quantity'] ?? 0;

          // Add the sub-collection document ID to the data
          fertilizerData.add({
            'documentId': doc.id, // Add the document ID here
            'name': name,
            'nitrogen': nitrogen,
            'phosphorus': phosphorus,
            'potassium': potassium,
            'price': price,
            'quantity': quantity,
          });
        }

        result['Fertilizers'] = fertilizerData;
      }
    } catch (e) {
      print("Error in getFertilizerData: $e");
    }

    return result;
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

  //get currentUserId
  String get currentUserUid => _getCurrentUserUid();

}
