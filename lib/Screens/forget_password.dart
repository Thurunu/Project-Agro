import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/custom/my_button.dart';
import 'package:project_algora_2/custom/my_text.dart';
import 'package:project_algora_2/custom/my_text_field.dart';

class ForgetPassword extends StatefulWidget {
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final resetMailController = TextEditingController();

  void dispose() {
    resetMailController.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetMailController.text);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password Reset Email Sent"),
          content: Text(
              "Check your email for instructions on resetting your password."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text("No user found for the provided email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Forget Password Text
              MyText("Forget Password", 30),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: MyText(
                    "Enter your email address to get password rest link. ", 18),
              ),

              //Email Text Box
              MyTextField(resetMailController, 'example@gmail.com',
                  'Your Email', false),
              //Submit Text Button
              MyButton(passwordRest, 'Rest Password'),

            ],
          ),
        ),
      ),
    );
  }
}
