import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_algora_2/Back/auth_page.dart';
import 'package:project_algora_2/widgets/background_circle.dart';

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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Lottie.asset(
                'assets/animations/tick.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            Align(alignment: Alignment.center,
              child: MyText(
                text: 'Done!',
                size: 26,
                color: Color.fromRGBO(0, 128, 128, 0.7),

                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            const MyText(
                text: "You'll be signed into your account in a moment.",
                size: 20,
                color: Color.fromRGBO(128, 128, 128, 1),
                fontWeight: FontWeight.bold),

            Align(alignment: Alignment.center,
                child: BackgroundCircle(height: 400, width: 400)),
          ],
        ),
      ),
    );
  }
}
