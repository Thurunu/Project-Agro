import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:project_algora_2/Back/auth_page.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


    @override
    void initState() {
      super.initState();


      Timer(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ),
        );
      }
      );
    }


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Lottie.asset('assets/animations/loading.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }
  }




