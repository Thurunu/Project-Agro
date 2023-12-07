import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/Back/back_end.dart';
import 'package:project_algora_2/Body/Pages/Back/crop_profile.dart';
import 'package:project_algora_2/Body/Pages/plant/crop/crop_field.dart';
import 'package:project_algora_2/widgets/Buttons/plant_adding_button.dart';

class UserPlantList extends StatefulWidget {
  const UserPlantList({super.key});

  @override
  State<UserPlantList> createState() => _UserPlantListState();
}

class _UserPlantListState extends State<UserPlantList> {
  List<Map<String, dynamic>> cropDataList = [];
  Map<String, String> imageMap = {}; // Map to store image URLs
  BackEnd backend = BackEnd();
  bool isRefreshing = false;
  DateTime cropDate = DateTime.now();
  String dateStatus = '';

  @override
  void initState() {
    super.initState();
    processCropData();
  }

  void openCropDetail(
      String documentId, String name, DateTime dateTime, String imageUrl) {
    // Parse the date string to a DateTime object
    DateTime cropDate = dateTime;

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference
    Duration difference = cropDate.difference(currentDate);
    int daysDifference = difference.inDays;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // You can create a new widget for the detailed view and pass the document ID to it.
          return CropField(
            name: name,
            imageUrl: imageUrl,
            day: daysDifference,
            plantedDate: cropDate,
          );
        },
      ),
    );
  }

  Future<void> processCropData() async {
    Map<String, dynamic> cropData = await backend.getCropData();

    if (!cropData.containsKey('Error')) {
      cropDataList = cropData['Crops'] ?? [];
    } else {
      String error = cropData['Error'];
      print("Error: $error");
    }

    // Fetch image URLs and document IDs for all crop items
    for (final cropItem in cropDataList) {
      final name = cropItem['name'] ?? '';
      final imageUrl = await backend.getImageUrl(name);

      // Include the document ID in the cropItem
      cropItem['documentId'] = cropItem['documentId'];

      imageMap[name] = imageUrl;

      // Calculate the cropDate and dateStatus for this crop item
      cropDate = cropItem['planted_data'];

      // Get the current date
      DateTime currentDate = DateTime.now();

      // Calculate the difference
      Duration difference = cropDate.difference(currentDate);
      int daysDifference = difference.inDays;

      if (daysDifference == 1) {
        dateStatus = 'Planted Date: Tomorrow';
      } else if (daysDifference > 1) {
        dateStatus = 'Planted Date: in $daysDifference days';
      } else if (daysDifference == 0) {
        dateStatus = 'Planted Date: Today';
      } else {
        dateStatus = 'Planted Date: ${-daysDifference} days ago';
      }
      print(dateStatus);
      setState(() {}); // Update the UI after refreshing
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crop List'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, // Set this property to false
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                // If not already refreshing, start the refresh process
                if (!isRefreshing) {
                  setState(() {
                    isRefreshing = true;
                  });

                  // Implement your refresh logic here, e.g., call processCropData() again
                  await processCropData();

                  // After data is refreshed, set isRefreshing to false
                  setState(() {
                    isRefreshing = false;
                  });
                }
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: cropDataList.length,
                itemBuilder: (context, index) {
                  final cropItem = cropDataList[index];
                  final name = cropItem['name'] ?? '';
                  final plantedData = cropItem['planted_data'];

                  final imageUrl = imageMap[name];
                  final documentId = cropItem['documentId'];
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        openCropDetail(documentId, name, plantedData,
                            imageUrl!); // Trigger the function with the document ID
                      },
                      child: Container(
                        width: screenWidth - 20,
                        height: screenHeight / 6,
                        child: CropProfile(
                          name: name,
                          date: plantedData,
                          imageUrl: imageUrl ?? '',
                          docId: documentId,
                          dateStatus: dateStatus, // Use the fetched image URL
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            PlantAddingButton(),
          ],
        ),
      ),
    );
  }
}
