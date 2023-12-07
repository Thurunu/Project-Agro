import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FarmerOrSeller {
  String uID = 'Not set';
  void userID() {
    final currentUser = FirebaseAuth.instance.currentUser!;
    if(currentUser != null){
      uID = currentUser!.uid;
    }
  }

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');
}
