import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  const MyText(this.text,this.size,{super.key});


  Widget build(context){
    return Text(
      text,style: TextStyle(fontSize: size),
    );
  }
}