import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/plant/add_crop_first_time.dart';

import '../../widgets/TextFields/custom_search_bar.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            AddCropFirstTime(),
            // CustomSearchBar(),
          ],
        ),
      ),
    );
  }
}
