import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_algora_2/Seller/fertilizer_back/take_photo.dart';

import 'image_preview_screen.dart';

class OpenCamera extends StatefulWidget {
  final String fertilizerName;
  const OpenCamera({super.key, required this.fertilizerName});

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  File? selectedImage;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null && _mounted) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });

      // Check if the widget is still mounted before navigating
      if (_mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewScreen(imagePath: selectedImage!.path, fertilizerName: widget.fertilizerName,),
          ),
        );
      }
    }
  }


  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Open Camera'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  TakePhoto(fertilizerName: widget.fertilizerName,),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Open Gallery'),
                onTap: () {
                 _openGallery(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Add Photos : '),
        IconButton(
          onPressed: () {
            _showOptions(context);
          },
          icon: Icon(Icons.camera_enhance_rounded),
        ),

      ],
    );
  }
}
