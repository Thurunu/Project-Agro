import 'package:camera/camera.dart';
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

    // webRecaptchaSiteKey: '6LcwisAoAAAAAK5WLiA4VIIwWUQjsGSuaIuQrUoT',
    androidProvider: AndroidProvider.debug,
  );

  final prefs = await SharedPreferences.getInstance();
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

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

