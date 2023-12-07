import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_algora_2/Seller/add_fertilizer.dart';
import 'package:project_algora_2/Seller/seller_home.dart';
import 'Pages/profile_page.dart';

class BottomNavBarSeller extends StatefulWidget {
  final int initialPage;
  const BottomNavBarSeller({super.key, required this.initialPage});

  @override
  State<BottomNavBarSeller> createState() => _BottomNavBarSellerState();
}

class _BottomNavBarSellerState extends State<BottomNavBarSeller> {
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
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
              child: PageView(
                controller: _pageController,
                children: const <Widget>[
                  SellerHome(), // First page (index 0)
                  AddFertilizers(),
                  ProfilePage(), // Fourth page (index 3)
                ],
                onPageChanged: (int index) {
                  setState(() {
                    _page = index; // Update the current page index
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastLinearToSlowEaseIn,
        index: _page, // Set the selected index based on the current page
        items:  const <Widget>[
          Icon(Icons.home), // Bottom navigation item 0 (Home)
          Icon(CupertinoIcons.plus_circle_fill,size: 50,),
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