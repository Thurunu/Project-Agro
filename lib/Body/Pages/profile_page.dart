import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Profile Page"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () async{

                try {
                  await FirebaseAuth.instance.signOut();
                } catch (e) {
                  print('Error signing out: $e');

              }
            }, child: Text("Sign Out")),
          ),
        ],
      ),
    );
  }
}
