import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  MyButton(this.onPressed, this.text, {super.key});

  Widget build(context) {

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
