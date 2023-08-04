import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_algora_2/custom/my_button.dart';
import 'package:project_algora_2/custom/my_text.dart';
import 'package:project_algora_2/custom/my_text_field.dart';
import '../Back/auth_service.dart';
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
  bool? isChecked = true;

  // Function to handle the user sign-up process
  void signUserIn() async {
    // Show a loading circle while the sign-up process is ongoing
    showDialog(
      context: context,
      builder: (context) {
        return  Center(
          child: Lottie.asset('assets/animations/loading.json',
          width: 200,
          height: 200,
            fit: BoxFit.fill,
          ),
        );
      },
    ).timeout(const Duration(seconds: 1), onTimeout: () => "timeout");
    try {
      // Check if the passwords match before creating the user account
      if (passwordController.text == confirmPasswordController.text) {
        // Create the user with email and password using FirebaseAuth
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );



      } else {
        print("Password doesn't match");
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e) {
      // If there's an error during sign-up, show an error message
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => Choice()),
    );
  }

  // Function to show an error message in an AlertDialog
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: Text('password mismatch'),
            ),
          );
        });
  }

  //Function to handle Google sign in process
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    // Call AuthService.signInWithGoogle() to handle the Google Sign-In process
    UserCredential? userCredential = await AuthService.signInWithGoogle();
    if (userCredential != null) {
      // The user is signed in successfully
      print("Signed in with Google: ${userCredential.user?.displayName}");

      // Navigate to the ChoiceScreen
      Navigator.pushReplacementNamed(context, '/Choice');
    } else {
      // Sign-in was not successful or was cancelled
      print("Sign-in with Google was not successful.");

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
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            //Background image add & formatted
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 75, bottom: 25),

                  //Headline
                  child: MyText("Let's Create An Account", 24),
                ),

                //Email Text Box
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: MyTextField(emailController, 'example@gmail.com', false),
                ),

                //New Password Text Box Section
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: MyTextField(
                      passwordController, 'new password', isChecked ?? false),
                ),

                //Confirm Password TextBox Section
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MyTextField(confirmPasswordController,
                      'confirm new password', isChecked ?? false),
                ),

                //Show Password check box section
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: Colors.blue,
                      tristate: false,
                      onChanged: (newBool) {
                        setState(() {
                          isChecked = newBool;
                        });
                      },
                    ),
                    const Text('Show password'),
                  ],
                ),

                //Signup button section
                SizedBox(
                  height: 65,
                  width: 360,
                  child: MyButton(
                      signUserIn,
                      'Sign up'
                  ),
                ),
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
                        child: MyText('Or continue with', 12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () => _handleGoogleSignIn(context),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the border radius
                          ),
                          primary: Colors.white, // Set button background color
                          side:
                              BorderSide(color: Colors.black), // Setborder color
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Continue With Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
