import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/location_detect.dart';
import 'package:project_algora_2/Body/read_data/get_crop_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool locationDetected = false;
  String zone = 'unknown_zone';

  void updateLocation(bool value) {
    print("********************Pressed**********");
    setState(() {
      locationDetected = value;
    });
  }
  void updateZone(String value){
    print('*************update zone************');
    setState(() {
      zone = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      updateLocation(true);
                    },
                    child: LocationDetector(
                      onZoneChanged: (newZone) {
                        // Do something with the new zone value in the other class/widget
                        print("Zone changed to: $newZone");
                        updateZone(newZone);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: const Text(
                  "Popular crops in your area",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              // Place your GetCropDetails widgets here as needed
              GetCropDetails(
                screenWidth: screenWidth,
              documentID: zone,
              ),

            ],
          )

        ),
      ),
    );
  }
}
