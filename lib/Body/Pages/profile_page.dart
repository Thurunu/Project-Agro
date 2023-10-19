import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/profile/profile_settings.dart';
import '../../widgets/Buttons/buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'No Name';

  final currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference userCollection = FirebaseFirestore.instance.collection('user_details');


  void initState(){
    super.initState();
    getData();
  }
  void getData() async {
    final uid = currentUser?.uid;

    userCollection.doc(uid).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        String name = doc.get('name');
        setState(() {
          username = name;
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.025,
            horizontal: screenWidth * 0.03,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade50,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.green.shade400,
                        shadows: <Shadow>[
                          Shadow(color: Colors.green.shade800, blurRadius: 5.0),
                        ],
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Center(
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.05),
              GestureDetector(
                onTap: () {
                  //Button function goes here
                },
                child: Material(
                  elevation: 4, // Elevation for a shadow effect
                  borderRadius: BorderRadius.circular(8),
                    color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Buttons(labelText: 'Crops', iconData: Icons.grass),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              GestureDetector(
                onTap: () {
                  //Button function goes here
                },
                child: Material(
                  elevation: 4, // Elevation for a shadow effect
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Buttons(labelText: 'Fertilizers', iconData: Icons.shopping_basket),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              GestureDetector(
                onTap: () {
                  //Button function goes here
                },
                child: Material(
                  elevation: 4, // Elevation for a shadow effect
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Buttons(labelText: 'Shops', iconData: Icons.shopping_bag),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              GestureDetector(
                onTap: () {
                  //Button function goes here
                },
                child: Material(
                  elevation: 4, // Elevation for a shadow effect
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Buttons(labelText: 'Help', iconData: Icons.support,),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              GestureDetector(
                onTap: () {
                  //Button function goes here
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context){
                      return const ProfileSettings();
                    })
                  );
                },
                child: Material(
                  elevation: 4, // Elevation for a shadow effect
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Buttons(labelText: 'Settings', iconData: Icons.settings,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
