import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CropFieldBackEnd {
  Map<String, dynamic> cropsFertilizerData = {};
  DateTime date = DateTime.now();
  String week = "1_week";
  List<int> weekStore = [];
  int feed = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('crop_fertilizers');

  Future<bool> _doesDocumentExist(String cropName) async {
    try {
      var docSnapshot = await _userCollection.doc(cropName).get();
      return docSnapshot.exists && docSnapshot.data() != null;
    } catch (e) {
      // Consider how to handle this error properly
      throw Exception('Failed to check document existence: $e');
    }
  }

  Future<void> fetchData(String cropName, DateTime plantedDate) async {
    date = plantedDate;
    if (await _doesDocumentExist(cropName)) {
      try {
        var cropData = await _getDocumentData(cropName);
        // Process and work with 'cropData' here
        // Consider removing this print statement in production code
        cropsFertilizerData = cropData!;
        cropsFertilizerData.forEach((key, value) {
          week = key;
          int? n = int.tryParse(week[0]);
          weekStore.add(n!);
          print('Document data: $weekStore');
          calculate();
        });
      } catch (e) {
        // Handle the error appropriately
        print('Failed to fetch data: $e');
      }
    } else {
      // Handle the case where the document does not exist
      print('Document for $cropName not found or has no data.');
    }
  }

  Future<Map<String, dynamic>?> _getDocumentData(String cropName) async {
    var docSnapshot = await _userCollection.doc(cropName).get();
    if (docSnapshot.exists && docSnapshot.data() != null) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception(
          'Document for $cropName does not exist or has no fields.');
    }
  }

  void calculate() {
    DateTime today = DateTime.now();
    int daysPassed = today.difference(date).inDays;

    int weeksPassed = (daysPassed / 7).floor();

    print('Days passed since planting: $daysPassed');
    print('Weeks passed since planting: $weeksPassed');

    int weeksThreshold = 1; // Define the threshold for "close" in weeks

    if (weekStore.isNotEmpty) {
      int daysLeft = 0;
      int closestWeek = weekStore.reduce((a, b) =>
      (a - weeksPassed).abs() < (b - weeksPassed).abs() ? a : b);

      int difference = (closestWeek - weeksPassed).abs();

      if (difference <= weeksThreshold) {
        // Calculate how many days are left for the closest week
        daysLeft = ((closestWeek - weeksPassed) * 7) - daysPassed;
        print('Closest week: $closestWeek, Days left: $daysLeft');
        feed = daysLeft;
      } else {
        print('No close week found within the threshold.');
      }
      feed = daysLeft;
    } else {
      print('No data available in weekStore.');
    }

  }

  int getFeedDay(){
    return feed;
  }


}
