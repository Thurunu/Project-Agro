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
  bool isSearchBarTap = false;
  bool locationDetected = false;
  TextEditingController controller = TextEditingController();
  String zone = 'unknown_zone';
  List<String> savedSearchItems = [];

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
                        updateZone(newZone);
                      },
                    ),
                  ),
                ),
              ),

              // Search bar
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth % 20, right: screenWidth % 20),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        SearchBar(
                          controller: controller,
                          hintText: 'Search...',
                          onTap: () {
                            setState(() {
                              isSearchBarTap = true;
                            });
                          },
                          trailing: <Widget>[
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isSearchBarTap) {
                                    savedSearchItems.add(controller.text);
                                    if (savedSearchItems.length > 5) {
                                      String item = savedSearchItems[0];
                                      savedSearchItems.remove(item);
                                    }
                                  }
                                });
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        ),
                        if (isSearchBarTap)
                          Container(
                            height: (savedSearchItems.length > 5
                                    ? 5
                                    : savedSearchItems.length) *
                                50,
                            color: Colors.grey.withOpacity(0.2),
                            child: ListView.builder(
                              itemCount: savedSearchItems.length > 5
                                  ? 5
                                  : savedSearchItems.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(savedSearchItems[index]),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Popular crops in your area",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Place your GetCropDetails widgets here as needed
              GetCropDetails(
                screenWidth: screenWidth,
                documentID: zone,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Mostly used fertilizers",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 110,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.purple.shade400,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Urea',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Additional Text asdfghjgfds',
                                style: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Image.asset('assets/test/Tomato.png'), // Add the image here
                      )

                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
