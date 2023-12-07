import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class PickDate extends StatelessWidget {
  bool plantedOnot;
  final Function(DateTime) dateSelected;
  PickDate({required this.plantedOnot, super.key, required this.dateSelected});

  @override
  Widget build(BuildContext context) {
    DatePickerController _controller = DatePickerController();
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime.now().subtract(const Duration(days: 30));
    int length = 30;

    final text1 = 'Description 1';
    final text2 = 'Description 2';

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Row(
            children: [
              Text(
                plantedOnot
                    ? 'When did you planted'
                    : 'When do you expect to plant it',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context:
                        context, // You need to have a valid BuildContext to show the dialog.
                    builder: (context) {
                      return AlertDialog(
                        alignment: Alignment(1.0, 0.325),
                        backgroundColor: Colors.green.withOpacity(0.5),
                        title: Text(
                          plantedOnot ? text1 : text2,
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.help, size: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: DatePicker(
             plantedOnot ? firstDate : now ,  // Minimum date (restricts how far back the user can select a date)
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: now,  // Initial date to display
              daysCount: length,
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,

              onDateChange: (date) {
                // New date selected

                dateSelected(date);
              },
            ),
          ),
        ],
      ),
    );
  }
}
