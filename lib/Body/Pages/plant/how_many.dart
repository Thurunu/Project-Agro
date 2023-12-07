import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HowMany extends StatefulWidget {
  final Function(int) numberSelected;
  const HowMany({super.key, required this.numberSelected});

  @override
  State<HowMany> createState() => _HowManyState();
}

class _HowManyState extends State<HowMany> {
  int _currentValue = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              Text('How many :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              SizedBox(
                height: 100, // Adjust the height here as needed
                child: Center(
                  child: NumberPicker(
                    minValue: 0,
                    maxValue: 100,
                    value: _currentValue,
                    onChanged: (value){
                      setState(() {
                        _currentValue = value;
                      });

                      widget.numberSelected(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
