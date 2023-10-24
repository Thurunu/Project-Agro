import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/Back/crop_profile.dart';

class UserPlantList extends StatelessWidget {
  const UserPlantList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          title: Text('Crop List'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
body: Padding(
  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,),
  child:   Column(

    mainAxisAlignment: MainAxisAlignment.start,

    crossAxisAlignment: CrossAxisAlignment.center,

    children: [

        Container(

          height: screenHeight/6, // Set the desired height

          child: CropProfile(),

        ),

    ],

  ),
),
      ),
    );
  }
}


