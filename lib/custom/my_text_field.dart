import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  const MyTextField(this.controller,this.hintText,this.labelText,this.obscureText,{super.key});

  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            const BorderSide(color: Colors.lightBlueAccent),

        ),
      ),
    );
  }
}