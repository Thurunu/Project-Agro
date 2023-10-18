import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Back/login_or_signup.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Text("Username or Password incorrect!");
          } else
            // user is logged in
          if (snapshot.hasData) {
            return const BottomNavBarScreen(initialPage: 0,);
          }

          // user is NOT logged in
          else {
            return LoginOrSignup();
          }
        },
      ),
    );

  }
}