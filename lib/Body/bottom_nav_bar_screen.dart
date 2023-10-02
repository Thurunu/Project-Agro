import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/iot_page.dart';
import 'Pages/plant_page.dart';
import 'Pages/profile_page.dart';
import 'Pages/home_page.dart';

 int _lastSelectedPage = 0;
class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _page = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _loadLastPage();
    _pageController = PageController(initialPage: _lastSelectedPage);

  }

  // Load the last selected page from SharedPreferences
  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print('**********************************');
      print(_lastSelectedPage);
      _lastSelectedPage = prefs.getInt('lastSelectedPage')!;
      _page = _lastSelectedPage;
    });
  }

  // Save the current selected page to SharedPreferences
  Future<void> _saveLastPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastSelectedPage', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _page = index;
            _saveLastPage(index); // Save the current page
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastLinearToSlowEaseIn,
        index: _page,
        items: const <Widget>[
          Icon(Icons.home),
          FaIcon(FontAwesomeIcons.leaf),
          FaIcon(FontAwesomeIcons.microchip),
          Icon(Icons.person),
        ],
        color: Colors.blueAccent,
        backgroundColor: Colors.yellowAccent,
        height: 60.0,
        onTap: (int index) {
          setState(() {
            print('taping index*******************');
            print(_page);
            _lastSelectedPage = _page;
            _pageController.jumpToPage(index);
            _saveLastPage(index); // Save the current page
          });
        },
      ),
    );
  }
}

