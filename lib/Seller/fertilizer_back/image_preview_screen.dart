import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_algora_2/Seller/fertilizer_back/fertilizer_backend.dart';
import 'package:project_algora_2/Seller/fertilizer_back/take_photo.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;
  final String fertilizerName;
  const ImagePreviewScreen({super.key, required this.imagePath, required this.fertilizerName});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  File? selectedImage;
  bool _mounted = false;
  FertilizerBackend backend = FertilizerBackend();

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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null && _mounted) {
      setState(() {
        selectedImage = File(pickedFile.path);
        print(selectedImage);
      });

      // Check if the widget is still mounted before navigating
      if (!_mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImagePreviewScreen(imagePath: selectedImage!.path, fertilizerName: widget.fertilizerName,),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        actions: [
          IconButton(
            onPressed: () {
              backend.setFertilizerName(widget.fertilizerName);
              backend.setImageAddress(widget.imagePath);
              backend.uploadImageToFirebase();
              backend.setFertilizerName(widget.fertilizerName);
              // print(selectedImage);
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.file(
            File(widget.imagePath),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  TakePhoto(fertilizerName: widget.fertilizerName,),
                    ),
                  );
                },
                child: Icon(Icons.camera_alt),
              ),
              ElevatedButton(
                onPressed: () {
                  _openGallery(context);
                },
                child: Icon(Icons.photo_library_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
