import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final Widget eventCard;

  const CustomTimeLine({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Color.fromRGBO(0, 128, 128, 0.6) : Color.fromRGBO(0, 128, 128, 0.6),
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast ? Color.fromRGBO(0, 128, 128, 1) :Color.fromRGBO(0, 128, 128, 0.6),
          iconStyle: IconStyle(
            iconData: isPast ? Icons.done : Icons.do_not_disturb_on,
            color: isPast ? Colors.white : Color.fromRGBO(0, 128, 0, 1),
          ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: eventCard,
        ),
        ),

    );
  }
}
