import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text('HomeScreen'),
            ),
            Text(user.email!),
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }, icon: const Icon(Icons.logout_outlined))
          ],
        ),
      ),
    );
  }
}
