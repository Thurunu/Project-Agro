import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final Function(String) onSelectedPlant;
  const CustomDropDownMenu({super.key, required this.onSelectedPlant});

  String get getSelectedValue => getSelectedValue;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String selectedValue = 'none';



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedValue,
              padding: const EdgeInsets.all(20.0),
              style: const TextStyle(color: Color.fromRGBO(0, 128, 128, 1)),
              underline: Container(
                height: 2,
                color: Color.fromRGBO(0, 128, 128, 0.7),
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!; // Update the selected value
                  widget.onSelectedPlant(value);
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'none',
                  child: Text('Select Crop',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                ),DropdownMenuItem(
                  value: 'Tomato',
                  child: Text('Tomato '),
                ),
                DropdownMenuItem(
                  value: 'Chili',
                  child: Text('Chili'),
                ),
                DropdownMenuItem(
                  value: 'Potato',
                  child: Text('Potato'),
                ),
                DropdownMenuItem(
                  value: 'Carrot',
                  child: Text('Carrot'),
                ),
                DropdownMenuItem(
                  value: 'Capsicum',
                  child: Text('Capsicum'),
                ),

              ],
              isExpanded: true,
            ),

          ],
        ),

    );
  }
}