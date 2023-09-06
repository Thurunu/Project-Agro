import 'package:flutter/material.dart';

import '../widgets/background_circle.dart';
import '../widgets/description_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: BackgroundCircle(height: 300.0,width: 300.0),
            ),
            DescriptionField(currentWidth: currentWidth, cropName: "Tomato"),
          ],
        ),
      ),
    );
  }
}


