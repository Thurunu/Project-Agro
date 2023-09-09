import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Pages/iot_page.dart';
import 'Pages/plant_page.dart';
import 'Pages/profile_page.dart';
import 'Pages/home_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _page = 3;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomeScreen(),
          PlantPage(),
          IOTPage(),
          ProfilePage(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        items: const <Widget>[
          Icon(Icons.home),
          FaIcon(FontAwesomeIcons.leaf),
          FaIcon(FontAwesomeIcons.microchip),
          Icon(Icons.person),
        ],
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
