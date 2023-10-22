import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Pages/home_page.dart';
import 'Pages/iot_page.dart';
import 'Pages/plant_page.dart';
import 'Pages/profile_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int initialPage;
  const BottomNavBarScreen({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _page = 0; // Initialize page index to 0 (Home)
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage;
    _pageController = PageController(initialPage: _page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent content from resizing when the keyboard appears
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomeScreen(), // First page (index 0)
          PlantPage(), // Second page (index 1)
          IOTPage(),   // Third page (index 2)
          ProfilePage(), // Fourth page (index 3)
        ],
        onPageChanged: (int index) {
          setState(() {
            _page = index; // Update the current page index
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastLinearToSlowEaseIn,
        index: _page, // Set the selected index based on the current page
        items: const <Widget>[
          Icon(Icons.home), // Bottom navigation item 0 (Home)
          FaIcon(FontAwesomeIcons.leaf), // Bottom navigation item 1 (Plant)
          FaIcon(FontAwesomeIcons.microchip), // Bottom navigation item 2 (IOT)
          Icon(Icons.person), // Bottom navigation item 3 (Profile)
        ],
        color: Colors.green.shade200,
        backgroundColor: Colors.green.shade50,
        height: 60.0,
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index); // Jump to the selected page
          });
        },
      ),
    );
  }
}
