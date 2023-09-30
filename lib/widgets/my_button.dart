import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  MyButton(this.onPressed, this.text, {super.key});

  Widget build(context) {

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(27, 94, 32, 0.9)),
            ),
            child: Text(
              text,

              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
