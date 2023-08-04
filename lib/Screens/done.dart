
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_algora_2/Back/auth_page.dart';
import 'package:project_algora_2/Screens/home_screen.dart';
import 'package:project_algora_2/custom/my_text.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  AuthPage(),
        ),
      );
    });
    return Container(
padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Lottie.asset('assets/animations/tick.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
    ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40,bottom: 20),
            child: MyText('All set.', 28),
          ),
          MyText("You'll be signed into your account in a moment.", 18),
        ],
      ),
    );
  }
}