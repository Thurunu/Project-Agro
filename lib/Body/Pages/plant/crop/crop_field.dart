import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/Pages/plant/crop/crop_status.dart';
import 'package:project_algora_2/Body/Pages/plant/crop/recommendations.dart';

class CropField extends StatefulWidget {
  const CropField({super.key});

  @override
  State<CropField> createState() => _CropFieldState();
}

class _CropFieldState extends State<CropField> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Crop image
            Container(
              width: screenWidth - 40,
              height: screenHeight / 5,
              child: DropShadowImage(
                image: Image.asset(
                  'assets/test/Tomato.png',
                ),
                borderRadius: 20,
                blurRadius: 20,
                offset: Offset(5, 5),
                scale: 0.9,
              ),
            ),
            // Soil moisture details
            Container(

              color: Colors.yellow[50],
              padding:
                  EdgeInsets.all(16), // Add padding to space out the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soil Moisture Status',
                    style: TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Make it bold
                    ),
                  ),
                  SizedBox(height: 8), // Add spacing between the text elements
                  Text('Last update today at 11.00 a.m',
                      style: TextStyle(fontSize: 12)),
                  SizedBox(height: 16), // Add more spacing
                  Row(
                    children: [
                      Text('Today : ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        height: 8,
                        width: screenHeight / 3,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add more spacing
                  Row(
                    children: [
                      Icon(Icons.paste),
                      SizedBox(
                          width: 8), // Add spacing between the icon and text
                      Text('History',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ],
              ),
            ),
            // Crop status
            Container(

              color: Colors.grey[50],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the text and button to the start and end of the row
                    children: [
                      Text('Crop Status',style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make it bold
              ),
            ),
                      TextButton(
                        onPressed: () {},
                        child: Text('setup'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing
                  cropStatus(
                      Icons.grass, 'Planting date', 'Nov 6', '28 days ago'),
                  SizedBox(height: 16), // Add spacing
                  cropStatus(Icons.health_and_safety, '1st dressing', 'Nov 25',
                      '2 days ago'),
                  SizedBox(height: 16), // Add spacing
                  cropStatus(Icons.water, 'Watering', 'Nov 23', '1 day ago'),
                ],
              ),
            ),
            // Recommendations
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Recommendations'),
                      TextButton(
                        onPressed: () {},
                        child: Text('see more'),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        recommendations('Planting',"Transplant the seedling to the field14-18 days after sowing."),
                        SizedBox(width: 10,),
                        recommendations('Fertilizing', "Mix 10 t/ha of well decomposed organic matter with the soil of selected field."),
                        SizedBox(width: 10,),
                        recommendations('Watering', "Don’t apply excess water specially in dry season. It causes fruit crack."),SizedBox(width: 10,),
                        recommendations('Watering', "Don’t apply excess water specially in dry season. It causes fruit crack."),
                      ],
                    ),
                  ),
                    ],
                  ),

              ),
          ],
        ),
      ),
    );
  }
}
