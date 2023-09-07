import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final resetMailController = TextEditingController();

  @override
  void dispose() {
    resetMailController.dispose();
    super.dispose();
  }
//validate email
  void validateEmail() {
    String email = resetMailController.text;
    if (email.isEmpty) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter your email address."),
          ),
        );
      });
    } else if (!EmailValidator.validate(email, true) ||
        !email.contains('@') ||
        !email.contains('.')) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid email address."),
          ),
        );
      });
    } else {
      passwordRest();
    }
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetMailController.text);
//Display message to user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset link sent to your email."),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("No user found for the provided email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
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
              const MyText("Forget Password", 30),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: MyText(
                    "Enter your email address to get password rest link. ", 18),
              ),

              //Email Text Box
              MyTextField(
                controller: resetMailController,
                hintText: 'example@gmail.com',
                labelText: 'Your Email',
                obscureText: false,
              ),
              //Submit Text Button
              MyButton(validateEmail, 'Rest Password'),
            ],
          ),
        ),
      ),
    );
  }
}
