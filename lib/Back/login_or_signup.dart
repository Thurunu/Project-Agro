import 'package:flutter/material.dart';
import '../Authentication/login_screen.dart';
import '../Authentication/signup_screen.dart';

class LoginOrSignup extends StatefulWidget{
  const LoginOrSignup({super.key});


  @override
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
  @override
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