import 'package:flutter/material.dart';
import 'package:project_algora_2/Back/login_or_signup.dart';
import 'intro_page_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences package
import 'intro_page_2.dart';
import 'intro_page_3.dart';
import 'intro_page_4.dart';

class OnBoardingController extends StatefulWidget {
  const OnBoardingController({
    super.key,
  });

  @override
  State<OnBoardingController> createState() => _OnBoardingControllerState();
}

class _OnBoardingControllerState extends State<OnBoardingController> {
  // Controller to keep track of which page we're on
  final PageController _controller = PageController();

  // Keep track of whether we're on the last page or not
  bool isLastPage = false; // Corrected variable name

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 3);
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
            ],
          ),
      ],
    ),
          // Dot indicators
          bottomSheet: isLastPage
              ? TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginOrSignup()), // Make sure HomePage is defined
              );
            },
            child: const Text("Get Started"),
          )
              : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _controller.jumpToPage(2), // Corrected controller variable
                  child: const Text('SKIP'),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller, // Corrected controller variable
                    count: 3,
                    effect: WormEffect(
                      spacing: 16,
                      dotColor: Colors.black26,
                      activeDotColor: Colors.teal.shade700,
                    ),
                    onDotClicked: (index) =>
                        _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                  child: const Text('NEXT'),
                ),
              ],
            ),
          ),




    );
  }
}
