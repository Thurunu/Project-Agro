import 'package:flutter/material.dart';

Widget recommendations(String topic, String description) {
  return Container(
    width: 125,
    height: 100
    ,
    color: Colors.green[100],
    child: Column(
      children: [
        Text(topic),
        Flexible(
          child: Text(
            description,
            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
            maxLines: 10,
          ),
        ),
      ],
    ),
  );
}
