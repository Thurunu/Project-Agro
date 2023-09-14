import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'Back/find.dart';

class LocationDetector extends StatefulWidget {
  const LocationDetector({Key? key}) : super(key: key);

  @override
  State<LocationDetector> createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  late String location = 'Where are you ?';
  late String agriculturalZone = ' ';

  String _currentAddress = " ";

  Future<void> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Location Service is not enabled");
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
                  this.location = _currentAddress;
                  this.agriculturalZone = agriculturalZone;
                });

              },
              child: Text(
                location,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(agriculturalZone),
          ],
        ),
      ),
      // home: Scaffold(
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         const Text("Location Coordinates"),
      //         Text(
      //             "Latitude: ${_currentLocation?.latitude} ; Longitude: ${_currentLocation?.longitude}"),
      //         const Text('Location Address'),
      //         Text(_currentAddress),
      //         ElevatedButton(
      //           onPressed: () async {
      //             await _getCurrentLocation();
      //             await _getAddressFromCoordinates();
      //             print("Location Detected");
      //             print(
      //                 "Latitude: ${_currentLocation?.latitude}, Longitude: ${_currentLocation?.longitude}");
      //             final agriculturalZone = Find(
      //                     latitude: _currentLocation!.latitude,
      //                     longitude: _currentLocation!.longitude)
      //                 .findAgriculturalZone();
      //             print("Agricultural Zone: $agriculturalZone");
      //           },
      //           child: const Text('Get Location'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
