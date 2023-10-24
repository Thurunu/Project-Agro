import 'package:flutter/material.dart';
import 'my_shape.dart';

class MyBarGraph extends StatefulWidget {
  final double screenWidth;
  final double todayPh;
  const MyBarGraph(
      {super.key, required this.screenWidth, required this.todayPh});
  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  double rightSide = 0;
  double leftSide = 0;

  @override
  void initState() {
    super.initState();
    setPosition();
  }
  @override
  void didUpdateWidget(covariant MyBarGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.todayPh != oldWidget.todayPh) {
      setPosition();
    }
  }

  void setPosition() {
    var width = widget.screenWidth;
    var today = widget.todayPh;
    if (today > 0 && today <= 14) {
      if (today >= 1 && today <= 7) {
        // Calculate rightSide based on the dividers (9, 7, 5, 3, 2.5, 2, 1.5, 1.4, 1.3, 1.2)
        int dividerIndex = 7 - today.toInt();
        num divider = [9, 7, 5, 3, 2.5, 2, 1.5, 1.4, 1.3, 1.2][dividerIndex];
        setState(() {
          rightSide = width / divider;
          leftSide = 0;
        });
      } else if (today >= 8 && today <= 14) {
        // Calculate leftSide based on the dividers (5, 2.5, 2, 1.5, 1.4, 1.3, 1.2)
        int dividerIndex =  today.toInt() - 8;
        num divider = [3.6, 3, 2.5, 1.9, 1.6, 1.3, 1.2][dividerIndex];
        setState(() {
          leftSide = width / divider;
          rightSide = 0;
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Column(
            children: [
              Text('Today',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('Refill',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.red,),),
                  Text('Optimal',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.green),),
                  Text('Overflow',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.purple),),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 12.0,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.lightGreenAccent,
                    Colors.green,
                    Colors.lightBlueAccent,
                    Colors.blue,
                    Colors.purpleAccent,
                    Colors.deepPurple
                  ],
                  stops: [0.0, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          SizedBox(
            height: 3,
          ),
          Padding(
            padding: EdgeInsets.only(left: leftSide, right: rightSide),
            child: ClipPath(
              clipper: MyShape(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
