import 'package:flutter/material.dart';

class FertilizerNutrients extends StatefulWidget {
  final Function(int) nitrogen;
  final Function(int) phosphorus;
  final Function(int) potassium;

  const FertilizerNutrients({super.key, required this.nitrogen, required this.phosphorus, required this.potassium});

  @override
  State<FertilizerNutrients> createState() => _FertilizerNutrientsState();
}

class _FertilizerNutrientsState extends State<FertilizerNutrients> {
  final TextEditingController _nitrogenController = TextEditingController();
  final TextEditingController _phosphorusController = TextEditingController();
  final TextEditingController _potassiumController = TextEditingController();

  @override
  void dispose() {
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Nitrogen
        const Text('N : '),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              controller: _nitrogenController,
              onChanged: (value) {
                setState(() {
                  widget.nitrogen(int.parse(value));
                });
              },
            ),
          ),
        ),

        // Phosphorus
        const SizedBox(width: 10),
        const Text('P : '),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              controller: _phosphorusController,
              onChanged: (value) {
                setState(() {
                  widget.phosphorus(int.parse(value));
                });
              },
            ),
          ),
        ),

        // Potassium
        const SizedBox(width: 10),
        const Text('K : '),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              controller: _potassiumController,
              onChanged: (value) {
                setState(() {
                  widget.potassium(int.parse(value));
                });
              },
            ),
          ),
        ),
      ],
    );
  }


  }
