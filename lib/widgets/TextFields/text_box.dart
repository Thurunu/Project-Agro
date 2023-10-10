import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String selectionName;
  const TextBox({super.key, required this.text, required this.selectionName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
