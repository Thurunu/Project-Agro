import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/Back/back_end.dart';
import 'package:project_algora_2/Body/Pages/plant/add_crop_first_time.dart';
import 'package:project_algora_2/Body/Pages/plant/user_plant_list.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  bool isThisUserFirstUse = false;
  var validate;

  @override
  void initState() {
    super.initState();

    BackEnd backend = BackEnd();
    validate = backend.isSecondSubCollectionEmpty();
    // backend.getCropData();

    validate.then((value) {
      if (value) {
        set();
      }
    }).catchError((error) {
      print("Error in isSecondSubcollectionEmpty: $error");
    });
  }

  void set() {
    setState(() {
      isThisUserFirstUse = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (isThisUserFirstUse)
              const AddCropFirstTime()
            else
              const UserPlantList(), // This part should be replaced with another widget
          ],
        ),
      ),
    );
  }
}
