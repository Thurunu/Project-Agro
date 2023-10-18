import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/OnBoarding/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/loading_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '226E2DFB-39F0-422B-97E7-20589920A3CF',
    androidProvider: AndroidProvider.debug,
  );

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
  runApp(
      MyApp(showHome: showHome)
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp(
      {
        super.key,
        required this.showHome,
      }
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      home: showHome ? const LoadingScreen() : const OnBoardingController(),
    );
  }
}

