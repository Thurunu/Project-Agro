import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_algora_2/Body/read_data/get_crop_details.dart';
import '../widgets/background_circle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String imageUrl;

  //document IDs
  final List<String> docIDs = [];

  //getDoc IDs
  Future<void> getDocIDs() async {
    await FirebaseFirestore.instance.collection("crop_details").get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.id);
            },
          ),
        );
  }

  // Sign out function
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(52, 168, 83, 0.05),
// color: Colors.green.shade800,
        animationDuration: const Duration(milliseconds: 500),

        items: const [
          Icon(Icons.home),
          FaIcon(FontAwesomeIcons.leaf),
          FaIcon(FontAwesomeIcons.microchip),
          Icon(Icons.person),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: BackgroundCircle(height: 300.0, width: 300.0),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: BackgroundCircle(height: 300.0, width: 300.0),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20),
              child: Text(
                "Popular crops in your area",
                style: TextStyle(
                  color: Color.fromRGBO(27, 94, 32, 0.9),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(onPressed: _signOut, child: Text("Sign Out")),
            FutureBuilder(
                future: getDocIDs(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return GetCropDetails(
                            doucmentID: docIDs[index],
                            width: currentWidth,
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
