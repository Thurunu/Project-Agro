import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/read_data/get_crop_details.dart';
import '../widgets/background_circle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String imageUrl;


  //document IDs
  final List<String> docIDs = [];


  //getDoc IDs
  Future<void> getDocIDs() async {

    await FirebaseFirestore.instance.collection("crop_details").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.id);
            docIDs.add(document.id);
            print(docIDs.length);
            print(docIDs);
          },
          ),
        );
  }


  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: BackgroundCircle(height: 300.0, width: 300.0),
            ),

            FutureBuilder(
              future: getDocIDs(),
                builder: (context, snapshot){

                return ListView.builder(
                  itemCount: docIDs.length,
                    itemBuilder: (context, index){
                    return GetCropDetails(doucmentID: docIDs[index],width: currentWidth,);
                    }
                );
                }
            ),
          ],

        ),
      ),
    );
  }
}
