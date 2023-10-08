import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/profile_page.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';
import 'package:project_algora_2/widgets/TextFields/text_box.dart';

import '../../../Back/auth_page.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: screenHeight * 0.15,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage('assets/images/user.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              currentUser.email!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 10.0,
              ),
              child: Text(
                'Saved Places',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            //user addresses
            const TextBox(
              text: 'Home',
              selectionName: 'Add home',
            ),

            //other options
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10.0),
              child: Text(
                'Other Options',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: _signOut,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Initial background color
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: Add rounded corners
                  ),
                  child: Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
