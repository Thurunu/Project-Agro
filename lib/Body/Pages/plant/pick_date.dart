import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class PickDate extends StatelessWidget {
  bool plantedOnot;
  final Function(DateTime) dateSelected;
  PickDate({required this.plantedOnot, super.key, required this.dateSelected});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day);
    DateTime firstDate = DateTime.now().subtract(const Duration(days: 30));
    DateTime lastDate = DateTime.now().add(const Duration(days: 365));

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
          Align(
            alignment: Alignment(0.0, 2.5),
            child: CalendarTimeline(
              initialDate: day,
              firstDate: firstDate,
              lastDate: lastDate,

              onDateSelected: (date) {
                dateSelected(date);
              },
              leftMargin: screenWidth / 6,
              shrink: false,
              monthColor: Colors.blue,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[400],
              dotsColor: const Color(0xFF333A47),
              // selectableDayPredicate: (date) => date.day != 0,
              locale: 'en_ISO',
              showYears: true,
            ),
          ),
        ],
      ),
    );
  }
}
