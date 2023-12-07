import 'package:flutter/material.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertilizer_backend.dart';

class FertilizerDescription extends StatefulWidget {
  final String documentID;
  final String fertilizerName;
  final String imageAddress;
  const FertilizerDescription({super.key, required this.documentID, required this.fertilizerName, required this.imageAddress});

  @override
  State<FertilizerDescription> createState() => _FertilizerDescriptionState();
}

class _FertilizerDescriptionState extends State<FertilizerDescription> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              height: 100,
              width: 125,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(172, 213, 178, 0.8),                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                widget.fertilizerName,
                style: TextStyle(fontSize: 20),
              ),
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 105),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
              image: DecorationImage(
                image: NetworkImage(widget.imageAddress),
                fit: BoxFit.contain,
              ),
            ),

          ),
        ),
      ],
    );
  }
}
