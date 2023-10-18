import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({super.key});

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String selectedValue = 'none';

  @override
  Widget build(BuildContext context) {
    return

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedValue,
              padding: const EdgeInsets.all(20.0),
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!; // Update the selected value
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'none',
                  child: Text('Select Crop'),
                ),DropdownMenuItem(
                  value: 'Tomato',
                  child: Text('Tomato '),
                ),
                DropdownMenuItem(
                  value: 'Chili',
                  child: Text('Chili'),
                ),
                DropdownMenuItem(
                  value: 'Cucumber',
                  child: Text('Cucumber'),
                ),
                DropdownMenuItem(
                  value: 'Carrot',
                  child: Text('Carrot'),
                ),
                DropdownMenuItem(
                  value: 'Lettuce',
                  child: Text('Lettuce'),
                ),
                DropdownMenuItem(
                  value: 'Onion',
                  child: Text('Onion'),
                ),
                DropdownMenuItem(
                  value: 'Pepper',
                  child: Text('Pepper'),
                ),
              ],
              isExpanded: true,
            ),

          ],
        ),

    );
  }
}