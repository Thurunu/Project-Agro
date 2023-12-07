// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_algora_2/widgets/constants.dart';
import '../Back/auth_service.dart';
import '../Body/bottom_nav_bar_screen.dart';
import '../widgets/Buttons/my_button.dart';
import '../widgets/TextFields/my_text_field.dart';
import '../widgets/TextFields/password_text_field.dart';
import '../widgets/background_circle.dart';
import '../widgets/TextFields/my_text.dart';
import 'choice.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen(this.onTap, {super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool showPassword = false;
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void validateEmail() {
    String email = emailController.text;
    if (email.isEmpty) {
      showSnackBarMessage("Please enter your email address.");
    } else if (!EmailValidator.validate(email, true) ||
        !email.contains('@') ||
        !email.contains('.')) {
      showSnackBarMessage("Please enter a valid email address.");
    } else {
      signUserIn();
    }
  }

  // Function to handle the user sign-up process
  void signUserIn() async {
    try {
      // Check if the passwords match before creating the user account
      if (passwordController.text == confirmPasswordController.text) {
        // Show a loading circle while the sign-up process is ongoing
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Lottie.asset(
                'assets/animations/loading.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            );
          },
        ).timeout(const Duration(seconds: 1), onTimeout: () => "timeout");
        // Create the user with email and password using FirebaseAuth
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Navigate to the Choice screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Choice()),
        );
      } else if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password Mismatch."),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      // If there's an error during sign-up, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(e.code),
            ),
          );
        },
      );
    }
  }
  void errorMessage(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  //Function to handle Google sign in process
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    UserCredential? userCredential = await AuthService.signInWithGoogle();
    if (userCredential != null) {
      // The user is signed in successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Signed in with Google: ${userCredential.user!.displayName}"),
          duration: const Duration(seconds: 3),
        ),
      );
      // Navigate to the HomeScreen
      // Navigator.pushReplacementNamed(context, '/bottom_nav_bar_screen');
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(
            initialPage: 0,
          ),
        ),
      );
    } else {
      // Sign-in was not successful or was cancelled
      errorMessage('Sign-in with Google was not successful.');

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-in with Google failed. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              //Background image add & formatted
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BackgroundCircle(height: 300.0, width: 300.0),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 75, bottom: 25),

                          //Headline
                          child: Text("Let's Create an Account",
                          style: kHeadingTextStyle,
                          ),
                        ),

                        //Email Text Box
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: MyTextField(
                            controller: emailController,
                            hintText: 'example@gmail.com',
                            labelText: 'Email',
                            obscureText: false,
                          ),
                        ),

                        //New Password Text Box Section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: PasswordTextField(
                            controller: passwordController,
                            hintText: 'new password',
                            labelText: 'New Password',
                          ),
                        ),

                        //Confirm Password TextBox Section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: PasswordTextField(
                            controller: confirmPasswordController,
                            hintText: 'confirm new password',
                            labelText: 'Confirm Password',
                          ),
                        ),

                        //Signup button section
                        SizedBox(
                          height: 65,
                          width: 360,
                          child: MyButton(validateEmail, 'Sign up'),
                        ),
                        //Divider
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.black54,
                                  thickness: 0.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: MyText(
                                    text: 'Or Continue With',
                                    size: 12,
                                    color: Colors.black12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black54,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Google Sign up button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () => _handleGoogleSignIn(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Background color
                                  foregroundColor: Colors.black, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Button border radius
                                  ),
                                  elevation: 5, // Shadow elevation
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                        10), // Add spacing between the image and text
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth / 100),
                                      child: const Text(
                                        'Continue With Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Already have an account? Login
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                  '\tLogin',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
