import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({super.key});

  String get getSelectedValue => getSelectedValue;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String selectedValue = 'none';
//   late String userUid;
// FirebaseFirestore ref = FirebaseFirestore.instance;
// final FirebaseAuth auth = FirebaseAuth.instance;
// CollectionReference userCollection = FirebaseFirestore.instance.collection('user_details');
//
// void inputData(){
//   final User? user = auth.currentUser;
//   final uid = user?.uid;
//   userUid = uid!;
// }
// void printAllDocs(){
//   userCollection.doc(userUid).get().then((DocumentSnapshot doc){
//     if(doc.exists)
//       print(doc.data());
//     else
//       print("No any doc");
//   }).catchError((error) {
//     print("Error getting document: $error");
//   });}

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedValue,
              padding: const EdgeInsets.all(20.0),
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (value) {
                setState(() {
                  // inputData();
                  // printAllDocs();
                  selectedValue = value!; // Update the selected value
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'none',
                  child: Text('Select Crop'),
                ),DropdownMenuItem(
                  value: 'Tomato',
                  child: Text('Tomato '),
                ),
                DropdownMenuItem(
                  value: 'Chili',
                  child: Text('Chili'),
                ),
                DropdownMenuItem(
                  value: 'Cucumber',
                  child: Text('Cucumber'),
                ),
                DropdownMenuItem(
                  value: 'Carrot',
                  child: Text('Carrot'),
                ),
                DropdownMenuItem(
                  value: 'Lettuce',
                  child: Text('Lettuce'),
                ),
                DropdownMenuItem(
                  value: 'Onion',
                  child: Text('Onion'),
                ),
                DropdownMenuItem(
                  value: 'Pepper',
                  child: Text('Pepper'),
                ),
              ],
              isExpanded: true,
            ),

          ],
        ),

    );
  }
}