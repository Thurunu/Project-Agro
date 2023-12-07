import 'package:flutter/material.dart';

class FertilizerName extends StatefulWidget {
  final Function(String) fertilizerName;
  const FertilizerName({super.key, required this.fertilizerName});

  @override
  State<FertilizerName> createState() => _FertilizerNameState();
}

class _FertilizerNameState extends State<FertilizerName> {
  final TextEditingController _controller = TextEditingController();
  String selectedValue = 'none';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField lost focus
        widget.fertilizerName(selectedValue);
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
    return Center(
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Enter Fertilizer Name'
        ),
        onChanged: (value){
          setState(() {

            selectedValue = value!;

          });
        },

      ),
    );
  }
}

