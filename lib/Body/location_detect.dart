import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Back/find.dart';

class LocationDetector extends StatefulWidget {
  final ValueChanged<String> onZoneChanged; //Callback Function
  const LocationDetector(
  {
    super.key,
    required this.onZoneChanged,
}
      );

  @override
  State<LocationDetector> createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  late String location = 'Where are you ?';
  late String zone = ' ';

  String _currentAddress = " ";

  @override
  void initState() {
    super.initState();
    _loadStoredData(); // Load stored location and zone when the app starts
  }

  // Function to load stored location and zone
  Future<void> _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      location = prefs.getString('location') ?? 'Where are you ?';
      zone = prefs.getString('zone') ?? ' ';
    });
  }

  Future<void> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location Service is Disabled'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _currentLocation = await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // _loadStoredData();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                print("Presed");
                await _getCurrentLocation();
                await _getAddressFromCoordinates();
                final agriculturalZone = Find(
                        latitude: _currentLocation!.latitude,
                        longitude: _currentLocation!.longitude)
                    .findAgriculturalZone();
                setState(() {
                  location = _currentAddress;

                  zone = agriculturalZone;
                });
                //Calling the callback to pass the update zone value
                widget.onZoneChanged(zone);
            // Store the updated location and zone information
                _storeData();
              },
              child: Text(
                location,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(zone),
          ],
        ),
      ),
    );
  }

  // Function to store location and zone information
  Future<void> _storeData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    prefs.setString('zone', zone);
  }
}
