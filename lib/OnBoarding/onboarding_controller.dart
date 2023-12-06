import 'package:flutter/cupertino.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
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
          ? Container(
              height: 65,
              width: screenWidth,
              color: Color.fromRGBO(32, 69, 37, 1),
              child: TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginOrSignup()), // Make sure HomePage is defined
                  );
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      width: 2.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(255, 255, 255, 0.8)),
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(
                          width: 2.0,
                          color: Colors.green,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                      ),
                      // You can customize the border width, color, and other properties
                    ),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w600),
                    ),
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
                      onDotClicked: (index) => _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(width: 2.0, color: Colors.green)),
                      // You can customize the border width, color, and other properties

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                      ),
                    ), // You can customize the border width, color, and other properties

                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
