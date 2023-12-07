import 'package:flutter/material.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertilizer_backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Body/location_detect.dart';
import 'fertilizer_back/ferilizer_description.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  bool locationDetected = false;
  TextEditingController controller = TextEditingController();
  String zone = 'unknown_zone';
  // List<String> savedSearchItems = [];
  FertilizerBackend backend = FertilizerBackend();
  String currentUserId = '';
  get isSearchBarTap => null;
  List<String> fertilizerNames = [];
  List<String> imageUrl = [];

  @override
  void initState() {
    super.initState();
    _loadZoneFromSharedPreferences();
    getLengthAndDocument();
  }

  Future<void> getLengthAndDocument() async {
    try {
      // Retrieve current user ID
      String currentUserId = backend.currentUserUid;
      print(currentUserId);

      // Retrieve all documents
      Map<String, dynamic> fertilizerData = await backend.getFertilizerData();

      setState(() {
        fertilizerNames = (fertilizerData['Fertilizers'] ?? [])
            .map<String>((fertilizer) => fertilizer['name'].toString())
            .toList();
      });

      // Now you can use fertilizerNames as needed in your application
      print(fertilizerNames);

      // Fetch image URLs one by one and store them in imageUrl list
      for (String name in fertilizerNames) {
        String url = await backend.getImageUrl(name, currentUserId);
        setState(() {
          imageUrl.add(url);
        });
        print("Image URL for $name: $url");
      }
    } catch (e) {
      print("Error in getLengthAndDocument: $e");
    }
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
                    right: screenWidth / 2,
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
              // Place your GetCropDetails widgets here as needed
              SizedBox(
                height: screenHeight, // Adjust the height as needed
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0, // Adjust the spacing between columns
                    mainAxisSpacing: 8.0,  // Adjust the spacing between rows
                  ),
                  itemCount: fertilizerNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < fertilizerNames.length && index < imageUrl.length) {
                      return FertilizerDescription(
                        documentID: currentUserId,
                        fertilizerName: fertilizerNames[index].toString(),
                        imageAddress: imageUrl[index].toString(),
                      );
                    } else {
                      // Handle the case where index is out of bounds
                      return Container(); // Placeholder or an empty container
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
