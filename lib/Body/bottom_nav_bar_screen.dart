import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Pages/iot_page.dart';
import 'Pages/plant_page.dart';
import 'Pages/profile_page.dart';
import 'home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    PlantPage(),
    IOTPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(52, 168, 83, 0.05),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          FaIcon(FontAwesomeIcons.leaf),
          FaIcon(FontAwesomeIcons.microchip),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
