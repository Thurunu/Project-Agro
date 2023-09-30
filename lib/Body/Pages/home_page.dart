import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/location_detect.dart';
import 'package:project_algora_2/Body/read_data/get_crop_details.dart';
import 'package:project_algora_2/widgets/my_text.dart';
import '../../widgets/background_circle.dart';

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


  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const LocationDetector(),
            ),
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


            FutureBuilder(
              future: getDocIDs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a circular progress indicator while loading data
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error case
                  return Text('Error: ${snapshot.error}');
                } else {
                  return FutureBuilder(
                    // Add a Future.delayed here to delay the content display
                    future: Future.delayed(Duration(seconds: 3), () => true),
                    builder: (context, delaySnapshot) {
                      if (delaySnapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator during the 3-second delay
                        return Center(child: CircularProgressIndicator());
                      } else {
                        // After the 3-second delay, display the GetCropDetails widgets
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GetCropDetails(
                                documentID: docIDs[index],
                                width: currentWidth,
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                }
              },
            )


          ],
        ),
      ),
    );
  }
}
