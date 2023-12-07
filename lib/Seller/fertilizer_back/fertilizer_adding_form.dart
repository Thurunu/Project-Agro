import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/plant/custom_timeline.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_seller.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertilizer_backend.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertilizer_name.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertlizer_nutrients.dart';
import 'package:project_algora_2/Seller/fertilizer_back/open_camera.dart';
import 'package:project_algora_2/Seller/fertilizer_back/quantity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fertilizer_price.dart';

class FertilizerAddingForm extends StatefulWidget {
  const FertilizerAddingForm({super.key});

  @override
  State<FertilizerAddingForm> createState() => _FertilizerAddingFormState();
}

class _FertilizerAddingFormState extends State<FertilizerAddingForm> {

  FertilizerBackend backend = FertilizerBackend();

  bool isThisUserFirstUse = false;
  bool selectedOptionIOT = true;
  int completedStages = 1; // Initialize with the first stage completed
  double divider = 2;
  double fertilizerPrice = 0.0;
  String fertilzerName = 'None';
  int subcollectionNumber = 0;
  int numberSelected = 1;
  int nitrogen = 0;
  int phosphorus = 0;
  int potassium = 0;

  @override
  void initState(){
    super.initState();
    // loadUserFirstUseStatus();
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
  // Future<void> loadUserFirstUseStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool firstUse = prefs.getBool('isThisUserFirstUse') ?? true;
  //   setState(() {
  //     isThisUserFirstUse = firstUse;
  //   });
  // }
  void handleFertilizerPrice(double price){
    setState(() {
      fertilizerPrice = price;
    });
    backend.setPrice(fertilizerPrice);

  }
  void handleSelectedNumber(int number){
    setState(() {
      numberSelected = number;
    });
    backend.setQuantity(numberSelected);
  }
  void handleNitrogen(int n){
    setState(() {
      nitrogen = n;
    });
    backend.setNitrogen(nitrogen);
    backend.isSecondSubCollectionEmpty();
  }
  void handlePhosphorus(int p){
    setState(() {
      phosphorus = p;
    });
    backend.setPhosphorus(phosphorus);
  }
  void handlePotassium(int k){
    setState(() {
      potassium = k;
    });
    backend.setPotassium(potassium);
  }

  void handleFertilizerName(String name) {
    setState(() {
      // print(name);
      fertilzerName = name;
    });
    backend.setFertilizerName(fertilzerName);
  }

  List<Widget> buildTimeLine() {
    final timelineItems = [
      // Define your timeline items here
      CustomTimeLine(
        isFirst: true,
        isLast: false,
        isPast: completedStages >= 1,
        eventCard:  FertilizerName( fertilizerName: handleFertilizerName,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: false,
        isPast: completedStages >= 2,
        eventCard: FertilizerNutrients(nitrogen: handleNitrogen, phosphorus: handlePhosphorus, potassium: handlePotassium,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: false,
        isPast: completedStages >= 3,
        eventCard: FertilizerPrice(price: handleFertilizerPrice,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: false,
        isPast: completedStages >= 4,
        eventCard: Quantity(numberSelected: handleSelectedNumber,),
      ),
      CustomTimeLine(
        isFirst: false,
        isLast: true,
        isPast: completedStages >= 5,
        eventCard:  OpenCamera(fertilizerName: fertilzerName,),
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
    if (completedStages < 5) {
      setState(() {
        divider = divider * 2.75;
        completedStages++; // Increment the completed stages
      });
    }
    else {
      backend.addDataToSubCollection('$fertilzerName$subcollectionNumber'); // Use the generated number
      updateSubcollectionNumber(); // Update the number for the next use
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBarSeller(initialPage: 0),
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
          "Let's add your fertilizer",
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
      //Next button
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
