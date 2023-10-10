import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_algora_2/Back/auth_page.dart';

import '../widgets/TextFields/my_text.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthPage(),
        ),
      );
    });
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Lottie.asset(
              'assets/animations/tick.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, bottom: 20),
            child: MyText(
              text: 'Done!',
              size: 24,
              color: Color.fromRGBO(27, 94, 32, 0.9),
              fontWeight: FontWeight.bold,
            ),
          ),
          const MyText(
              text: "You'll be signed into your account in a moment.",
              size: 14,
              color: Colors.black12,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}
