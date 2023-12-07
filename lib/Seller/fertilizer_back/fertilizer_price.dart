import 'package:flutter/material.dart';

class FertilizerPrice extends StatefulWidget {
  final Function(double) price;
  const FertilizerPrice({super.key, required this.price});

  @override
  State<FertilizerPrice> createState() => _FertilizerPriceState();
}

class _FertilizerPriceState extends State<FertilizerPrice> {
  final TextEditingController _controller = TextEditingController();
  double selectedValue = 0.0;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField lost focus
        widget.price(selectedValue);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('How much :'),
        SizedBox(
          width: 100,
          height: 50,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: const InputDecoration(hintText: '24.9'),
            onChanged: (value) {
              setState(() {
                selectedValue = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    );
  }
}
