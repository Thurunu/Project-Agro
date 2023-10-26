import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/Back/back_end.dart';
import 'package:project_algora_2/Body/Pages/plant/crop/crop_field.dart';
import 'package:project_algora_2/Body/Pages/plant/custom_dropdown_menu.dart';
import 'package:project_algora_2/Body/Pages/plant/custom_timeline.dart';
import 'package:project_algora_2/Body/Pages/plant/pick_date.dart';
import 'package:project_algora_2/Body/Pages/plant/selection_status_iot.dart';
import 'package:project_algora_2/Body/Pages/plant/selection_status_plant.dart';
import 'package:project_algora_2/Body/Pages/plant/user_plant_list.dart';
import 'package:project_algora_2/Body/Pages/plant_page.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlantAddingForm extends StatefulWidget {
  const PlantAddingForm({super.key});

  @override
  State<PlantAddingForm> createState() => _PlantAddingFormState();
}

class _PlantAddingFormState extends State<PlantAddingForm> {

  BackEnd be = BackEnd();
  bool isThisUserFirstUse = false;
  bool selectedOptionPlant = true;
  bool selectedOptionIOT = true;
  int completedStages = 1; // Initialize with the first stage completed
  double divider = 2.5;
  DateTime dateTime = DateTime.now();
  String cropName = 'None';
  int subcollectionNumber = 0;
  void initState(){
    super.initState();
    loadUserFirstUseStatus();
    loadSubcollectionNumber(); // Load the last saved number
  }
  Future<void> loadSubcollectionNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subcollectionNumber = prefs.getInt('subcollectionNumber') ?? 0;
  }

  Future<void> updateSubcollectionNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subcollectionNumber++;
    prefs.setInt('subcollectionNumber', subcollectionNumber);
  }
  Future<void> loadUserFirstUseStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstUse = prefs.getBool('isThisUserFirstUse') ?? true;
    setState(() {
      isThisUserFirstUse = firstUse;
    });
  }
  void handleSelectedDateTime(DateTime date){
    setState(() {
      dateTime = date;
    });
    be.setDate(date);

  }
  void handleOptionSelectedPlant(bool option) {
    setState(() {
      selectedOptionPlant = option;
    });
    be.setStatus(option);

  }void handleOptionSelectedIOT(bool option) {
    setState(() {
      selectedOptionIOT = option;
    });
    be.setIOT(option);
  }void handleSelectedPlant(String name) {
    setState(() {
      cropName = name;
    });
    be.setCropName(name);
  }

  List<Widget> buildTimeLine() {
    final timelineItems = [
      // Define your timeline items here
      CustomTimeLine(
        isFirst: true,
        isLast: false,
        isPast: completedStages >= 1,
        eventCard:  CustomDropDownMenu(onSelectedPlant: handleSelectedPlant,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: false,
        isPast: completedStages >= 2,
        eventCard: SelectionStatusPlant(
          onOptionSelected: handleOptionSelectedPlant,
        ),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: false,
        isPast: completedStages >= 3,
        eventCard: PickDate(plantedOnot: selectedOptionPlant, dateSelected: handleSelectedDateTime,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: true,
        isPast: completedStages >= 4,
        eventCard: SelectionStatusIOT(
          onOptionSelected: handleOptionSelectedIOT,
        ),
      ),
    ];
    // Filter the items based on the completed stages
    final visibleTimelineItems = timelineItems
        .where(
            (item) => item.isPast || item == timelineItems[completedStages - 1])
        .toList();

    return visibleTimelineItems;
  }

  void moveToNextStage()  {
    if(isThisUserFirstUse) {
      // be.addDataToSubcollection('default');
      setState(() {
        isThisUserFirstUse = true;
      });
    }
    if (completedStages < 4) {
      setState(() {
        divider = divider * 2.75;
        completedStages++; // Increment the completed stages
      });
    }
    else {
      be.addDataToSubcollection('$cropName$subcollectionNumber'); // Use the generated number
      updateSubcollectionNumber(); // Update the number for the next use
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(initialPage: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Let's add your crop",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight / divider,
            left: screenWidth * 0.025,
            right: screenWidth * 0.025),
        child: ListView(
          children: buildTimeLine(),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            moveToNextStage();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), // Remove border radius
            ),
            primary: Colors.black,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                'Next',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
