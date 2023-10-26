import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/Back/back_end.dart';
import 'package:project_algora_2/Body/Pages/Back/crop_profile.dart';
import 'package:project_algora_2/widgets/Buttons/plant_adding_button.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class UserPlantList extends StatefulWidget {
  const UserPlantList({super.key});

  @override
  State<UserPlantList> createState() => _UserPlantListState();
}

class _UserPlantListState extends State<UserPlantList> {
  List<Map<String, dynamic>> cropDataList = [];
  Map<String, String> imageMap = {}; // Map to store image URLs
  BackEnd backend = BackEnd();

  @override
  void initState() {
    super.initState();
    processCropData();
  }

  Future<void> processCropData() async {
    Map<String, dynamic> cropData = await backend.getCropData();

    if (!cropData.containsKey('Error')) {
      cropDataList = cropData['Crops'] ?? [];
    } else {
      String error = cropData['Error'];
      print("Error: $error");
    }

    // Fetch image URLs for all crop items
    for (final cropItem in cropDataList) {
      final name = cropItem['name'] ?? '';
      final imageUrl = await backend.getImageUrl(name);
      imageMap[name] = imageUrl;

      setState(() {}); // Trigger a UI update after each image is loaded
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cropDataList.length,
              itemBuilder: (context, index) {
                final cropItem = cropDataList[index];
                final name = cropItem['name'] ?? '';
                final plantedData = cropItem['planted_data'];
                final formattedDate = plantedData != null
                    ? "${plantedData.day}-${plantedData.month}-${plantedData.year}"
                    : '';
                final imageUrl = imageMap[name];
                return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: Container(
                      width: screenWidth - 20,
                      height: screenHeight / 6,
                      child: CropProfile(
                        name: name,
                        date: formattedDate,
                        imageUrl: imageUrl ?? '', // Use the fetched image URL
                      ),
                    ),
                );
              },
            ),
            PlantAddingButton(),
          ],
        ),
      ),
    );
  }
}





