import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Authentication/check_inbox.dart';
import '../widgets/Buttons/my_button.dart';
import '../widgets/TextFields/my_text.dart';
import '../widgets/TextFields/my_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() {
    return _ForgetPasswordState();
  }
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckInbox()),
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
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Forget Password Text
               const Row(
                 children: [
                   BackButton(),
                   MyText(
                      text: 'Forget Password',
                      size: 24,
                      color: Color.fromRGBO(27, 94, 32, 0.9),
                      fontWeight: FontWeight.bold),
                 ],
               ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: MyText(
                    text: 'Enter your email address to reset your password.',
                    size: 18,
                    color: Color.fromRGBO(27, 94, 32, 0.9),
                    fontWeight: FontWeight.normal),
              ),
SizedBox(height: 50,),
              //Email Text Box
              MyTextField(
                controller: resetMailController,
                hintText: 'example@gmail.com',
                labelText: 'Your Email',
                obscureText: false,
              ),
              //Submit Text Button
              Padding(
                padding: const EdgeInsets.only(top: 30), // Adjust the top padding to move the button down
                child: MyButton(validateEmail, 'Reset Password'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
