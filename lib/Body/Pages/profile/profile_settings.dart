import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/profile_page.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
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
