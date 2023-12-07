import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/widgets/constants.dart';
import '../Back/auth_service.dart';
import '../Body/bottom_nav_bar_screen.dart';
import '../widgets/Buttons/my_button.dart';
import '../widgets/TextFields/my_text_field.dart';
import '../widgets/TextFields/password_text_field.dart';
import '../widgets/background_circle.dart';
import '../widgets/TextFields/my_text.dart';
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
      validatePassword();
    }
  }

  void validatePassword() {
    String password = passwordController.text;
    if (password.isEmpty)
      showSnackBarMessage("Please enter your password.");
    else
      loginUserIn();
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
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(
            initialPage: 0,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      hideLoadingIndicator();
      if (e.code == 'user-not-found') {
        errorMessage('Incorrect Email');
      } else if (e.code == 'wrong-password') {
        errorMessage('Incorrect Password');
      }
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
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                //background decorations
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: BackgroundCircle(
                        height: screenHeight, width: screenWidth),
                  ),
                ),
                //Welcome Text
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 75, bottom: 25),
                      child: Text(
                        'Welcome back',
                        style: kHeadingTextStyle,


                      ),
                    ),
                    //Email text-field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'example@gmail.com',
                        labelText: 'Email',
                        obscureText: false,
                      ),
                    ),
                    //Password text-field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PasswordTextField(
                        controller: passwordController,
                        hintText: 'password',
                        labelText: 'Password',
                      ),
                    ),

                    //forget password button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ),
                            );
                          },
                          child: const Text("Forget Password ?"),
                        ),
                      ),
                    ),
                    //sign in button
                    MyButton(validateEmail, 'Sign In'),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                    //Goggle Sign In Button
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
