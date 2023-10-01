import 'package:flutter/material.dart';
import 'package:project_algora_2/Back/login_or_signup.dart';
import '../widgets/constants.dart';

class CheckInbox extends StatefulWidget {
  const CheckInbox({super.key});

  @override
  State<CheckInbox> createState() => _CheckInboxState();
}

class _CheckInboxState extends State<CheckInbox> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,


          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                  'assets/gif/Mailbox.gif',
                height: 500,
                fit: BoxFit.contain,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Check Your Inbox',
                  style: kHeadingTextStyle,
                ),
              ),
              const Text(
                'We have sent password recovery instructions to your mail.',
                style: kTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 20.0,
                ),
                child: SizedBox(
                  width: screenWidth,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        this.context,
                        MaterialPageRoute(builder: (context) => LoginOrSignup())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kLightGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 15.0,
                      ),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      side: const BorderSide(color: kRegularGreen),
                    ),
                    child: const Text(
                      'Back To Login',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
