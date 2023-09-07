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
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, //this will hide default border

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.lightBlueAccent),
        ),
      ),
    );
  }
}