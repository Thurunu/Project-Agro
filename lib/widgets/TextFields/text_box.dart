import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String selectionName;
  const TextBox({super.key, required this.text, required this.selectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(bottom: 15,left: 20.0),
      margin: EdgeInsets.only( top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Icon
          Icon(Icons.home),
          //selection name
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectionName,
                style: TextStyle(fontSize: 18, color: Colors.black38),
              ),
              //text
              Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
