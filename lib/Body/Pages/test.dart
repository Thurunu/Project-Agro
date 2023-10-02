import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/plant_page.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';

class TestingPurpose extends StatelessWidget {
  const TestingPurpose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return const BottomNavBarScreen();
                  })
              );
            }, icon: const Icon(Icons.arrow_back,size: 25,),),
          ],
        ),
      ),
    );
  }
}
