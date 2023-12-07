import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Back/login_or_signup.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_seller.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Username or Password incorrect!");
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            String userId = user?.uid ?? 'No User ID';
            CollectionReference userCollection =
            FirebaseFirestore.instance.collection('user_details');
            return FutureBuilder<DocumentSnapshot>(
              future: userCollection.doc(userId).get(),
              builder: (context, innerSnapshot) {
                if (innerSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (innerSnapshot.hasError) {
                  return const Text("Error loading user details");
                } else if (innerSnapshot.hasData) {
                  String userType = innerSnapshot.data!['user_type'];

                  if (userType == 'farmer') {
                    return BottomNavBarScreen(initialPage: 0);
                  } else if (userType == 'seller') {
                    return BottomNavBarSeller(initialPage: 0,);
                  } else {
                    return const Text("Unknown user type");
                  }
                } else {
                  return const Text("User details not found");
                }
              },
            );
          } else {
            // User is NOT logged in
            return LoginOrSignup();
          }
        },
      ),
    );
  }
}