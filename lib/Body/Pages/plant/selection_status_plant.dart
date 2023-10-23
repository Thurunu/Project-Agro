import 'package:flutter/material.dart';

class SelectionStatusPlant extends StatefulWidget {
  final Function(bool) onOptionSelected;
  const SelectionStatusPlant({super.key, required this.onOptionSelected});

  @override
  _SelectionStatusPlantState createState() => _SelectionStatusPlantState();
}

List<String> options = ['Yes', 'No'];

class _SelectionStatusPlantState extends State<SelectionStatusPlant> {
  String currentOption = options[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Planted  : ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, top: 2),
            child: Stack(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Radio(
                    value: options[0],
                    groupValue: currentOption,
                    onChanged: (value) {
                      setState(() {
                        currentOption = value!; // Set the current option directly
                        widget.onOptionSelected(true); // Call the callback

                      });
                    },
                  ),
                  title: Text(
                      options[0]), // Display 'Yes' next to the radio button
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      value: options[1],
                      groupValue: currentOption,
                      onChanged: (value) {
                        setState(
                          () {
                            currentOption = value!; // Set the current option directly
                            widget.onOptionSelected(false); // Call the callback

                          },
                        );
                      },
                    ),
                    title: Text(
                        options[1]), // Display 'No' next to the radio button
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
