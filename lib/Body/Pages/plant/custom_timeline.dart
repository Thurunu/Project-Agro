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
      height: 180,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.deepPurple : Colors.deepPurple.shade100,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast ? Colors.deepPurple : Colors.deepPurple.shade100,
          iconStyle: IconStyle(
            iconData: isPast ? Icons.done : Icons.do_not_disturb_on,
            color: isPast ? Colors.white : Colors.deepPurple.shade100,
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
