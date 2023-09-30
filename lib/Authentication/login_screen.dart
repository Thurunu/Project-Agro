import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Back/auth_service.dart';
import '../widgets/background_circle.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen(this.onTap, {super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
      loginUserIn();
    }
  }
  void showLoadingIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingIndicator() {
    Navigator.pop(context);
  }

  void loginUserIn() async {
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,


      );
      hideLoadingIndicator();
      Navigator.pushReplacementNamed(context, '/bottom_nav_bar_screen');
    } on FirebaseAuthException catch (e) {
      hideLoadingIndicator();
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }


  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    UserCredential? userCredential = await AuthService.signInWithGoogle();
    if (userCredential != null) {
      // The user is signed in successfully
      print("Signed in with Google: ${userCredential.user?.displayName}");

      // Navigate to the HomeScreen
      Navigator.pushReplacementNamed(context, '/bottom_nav_bar_screen');
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                //background decorations
                Padding(
                  padding: const EdgeInsets.only(top:150),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BackgroundCircle(height: 300.0, width: 300.0),
                  ),
                ),
                //Welcome Text
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 75, bottom: 25),
                      child: MyText(text: 'Welcome Back', size: 24, color: Color.fromRGBO(27, 94, 32, 0.9), fontWeight: FontWeight.bold,),
                    ),
                    //Email textfield
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'example@gmail.com',
                        labelText: 'Email',
                        obscureText: false,
                      ),
                    ),
                    //Password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyTextField(
                          controller: passwordController,
                          hintText: 'password',
                          labelText: 'Password',
                          obscureText: true),
                    ),
                    //Show Password check box section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: showPassword,
                          onChanged: (bool? value) {
                            setState(() {
                              showPassword = value!;
                            });
                          },
                        ),
                        Text('Show Password'),
                      ],
                    ),

                    //forget password button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          },
                          child: const Text("I've forget my password"),
                        ),
                      ),
                    ),
                    //sign in button
                    MyButton(validateEmail, 'Sign In'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black54,
                              thickness: 0.5,
                            ),
                          ),
                          //Divider
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: MyText(text: 'Or Continue With', size: 12, color: Colors.black12, fontWeight: FontWeight.w600),
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
                    //Goggle Sign In Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () => _handleGoogleSignIn(context),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // Background color
                              onPrimary: Colors.black, // Text color
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
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
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
                    //Move to sign up screen
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              '\tRegister now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}