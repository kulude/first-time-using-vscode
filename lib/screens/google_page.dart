import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GooglePage extends StatefulWidget {
  const GooglePage({super.key});
  @override
  State<GooglePage> createState() => _GooglePageState();
}

class _GooglePageState extends State<GooglePage> {
  File? _file;
  Uint8List? _imageInBytes;

  void _pickImage() async {
    try {
      final pickeImage = ImagePicker();
      final pickedImage = await pickeImage.pickImage(
        source: ImageSource.gallery,
      );

      // if (pickedImage != null) {
      //   setState(() {
      //     _file = File(pickedImage.path);  only works with android and ios not web
      //   });
      // }

      if (pickedImage != null) {
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _imageInBytes = bytes;
          print('Image picked successfully: ${pickedImage.path}');
        });
      }

      final base64String = base64Encode(_imageInBytes!);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imageString', base64String);
      print('Image saved to SharedPreferences');
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _loadImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final base64String = prefs.getString('imageString');

      if (base64String != null) {
        final bytes = base64Decode(base64String);
        setState(() {
          _imageInBytes = bytes;
          // _file = File.fromRawPath(bytes);
        });
        print('Image loaded successfully from SharedPreferences');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print('screen height: $screenHeight');
    return Scaffold(
      appBar: AppBar(title: const Text('image picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //_file != null
            // ? Container(
            //     margin: const EdgeInsets.all(20),
            //     child: Image.file(_file!, fit: BoxFit.fill),
            //   )
            // : const Text('No images Selected'),
            //SizedBox(height: 4),
            _imageInBytes != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      margin: EdgeInsets.all(screenWidth * 0.01),
                      child: AspectRatio(
                        aspectRatio: 3 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _imageInBytes!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : const Text('No images Selected'),
            SizedBox(height: 4),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Text('Navigate to serch screen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
