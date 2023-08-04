import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/custom/my_button.dart';
import 'package:project_algora_2/custom/my_text.dart';
import 'done.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  Future<String?> currentUserId() async {
    final User? user = await FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<void> usersData(String? uid, String status) async {
    if (uid != null) {
      try {
        String userType = status;
        await FirebaseFirestore.instance
            .collection('user_details')
            .doc(uid)
            .set({'user_type': userType})
            .then((value) => print("User Added"));
      } catch (e) {
        print("Failed to add user: $e");
      }
    } else {
      // Handle the case when the user ID is null
      print("User ID is null.");
    }
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => Done()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder<String?>(
            stream: currentUserId().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error occurred while creating the database");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for the user ID
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                // User is logged in, so get the user ID from the snapshot data
                String uid = snapshot.data!;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 75, left: 20),
                        child: MyText('Select Account Type', 24),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, left: 20, bottom: 30),
                        child: MyText("Don't Worry this can be changed later", 16),
                      ),
                      MyButton(() => usersData(uid, 'farmer'), 'Farmer'),
                      MyButton(() => usersData(uid, 'seller'), 'Seller'),
                    ],
                  ),
                );
              } else {
                // User is NOT logged in, show appropriate UI here
                return Text("Not logged in");
              }
            },
          ),
        ),
      ),
    );
  }
}
