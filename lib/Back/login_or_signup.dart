import 'package:flutter/material.dart';
import 'package:project_algora_2/Screens/login_screen.dart';
import 'package:project_algora_2/Screens/signup_screen.dart';

class LoginOrSignup extends StatefulWidget{

  State<LoginOrSignup> createState(){
    return _LoginOrSignupState();
  }
}
class _LoginOrSignupState extends State<LoginOrSignup>{

  bool showLoginScreen = true;

  // Function to toggle between Login and Signup screens
  void toogleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    }
    );
  }

  // Build method to return either the LoginScreen or SignupScreen based on the 'showLoginScreen' flag
  Widget build(BuildContext context){

    if(showLoginScreen) {
      return LoginScreen(
        toogleScreens,

      );

    }
      else {

      // If 'showLoginScreen' is false, display the SignupScreen
      return SignupScreen(
        toogleScreens,
      );
    }
    }
    }
