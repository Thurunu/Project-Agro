import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/read_data/get_fertilizers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Body/location_detect.dart';
import '../Body/read_data/get_crop_details.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  bool locationDetected = false;
  TextEditingController controller = TextEditingController();
  String zone = 'unknown_zone';
  List<String> savedSearchItems = [];

  get isSearchBarTap => null;

  @override
  void initState() {
    super.initState();
    _loadZoneFromSharedPreferences();
  }

  void updateLocation(bool value) {
    setState(() {
      locationDetected = value;
    });
  }

  void updateZone(String value) {
    setState(() {
      zone = value;
    });
    _saveZoneToSharedPreferences(value); // Save the zone to SharedPreferences
  }

  Future<void> _loadZoneFromSharedPreferences() async {
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight % 50),
                child: SizedBox(
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      updateLocation(true);
                    },
                    child: LocationDetector(
                      onZoneChanged: (newZone) {
                        updateZone(newZone);
                      },
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight / 20,
                    right: screenWidth / 5,
                    bottom: screenHeight % 10,
                  ),
                  child: const Text(
                    "Your Fertilizers",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              // Place your GetCropDetails widgets here as needed
              GetFertilizers(
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
