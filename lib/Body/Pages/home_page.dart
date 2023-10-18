import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/location_detect.dart';
import 'package:project_algora_2/Body/read_data/get_crop_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool locationDetected = false;
  String zone = 'unknown_zone';

  void initState(){
    super.initState();
    _loadZoneFromSharedPreferences();
  }

  void updateLocation(bool value) {
    // print("********************Pressed**********");
    setState(() {
      locationDetected = value;
    });
  }

  void updateZone(String value) {
    // print('*************update zone************');
    setState(() {
      zone = value;
    });
    _saveZoneToSharedPreferences(value); // Save the zone to SharedPreferences

  }
  //Support method to load zone from SharedPreference
  Future<void> _loadZoneFromSharedPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    final savedZone = prefs.getString('zone') ?? 'unknown_zone';
    setState(() {
      zone = savedZone;
    });
  }

  // Helper method to save zone to SharedPreferences
  Future<void> _saveZoneToSharedPreferences(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('zone', value);
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
                        // print("Zone changed to: $newZone");
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
          ),
        ),
      ),
    );
  }
}
