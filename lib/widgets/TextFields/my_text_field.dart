import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  const MyTextField(
  {
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    Key? key
  }
      ): super(key: key);

  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 16,
      color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.green[300]),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.green, fontSize: 20,fontWeight: FontWeight.w500),
        filled: true,
        fillColor: Colors.green[100],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, //this will hide default border

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color.fromRGBO(0, 128, 0, 0.7)),
        ),
      ),
    );
  }
}