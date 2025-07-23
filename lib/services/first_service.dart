import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_class.dart';

class FirstService extends ChangeNotifier {
  final List<String> _imageList = [
    'assets/images/pexels-1.jpg',
    'assets/images/pexels-2.jpg',
    'assets/images/pexels-3.jpg',
    'assets/images/pexels-4.jpg',
    'assets/images/pexels-5.jpg',
    'assets/images/pexels-6.jpg',
  ];

  //final List<String> _emptyImageList = [];  not neccessary since I will use it in the ui

  List<String> get imageList => List.unmodifiable(_imageList);

  final List<ImageClass> _objectImageList = [];

  List<ImageClass> get objectImageList => List.unmodifiable(_objectImageList);

  void addImage(String imageUrl) {
    if (_imageList.contains(imageUrl) || imageUrl.isEmpty) {
      if (_imageList.contains(imageUrl)) {
        return;
      } else {
        return;
      }
    }
    _imageList.add(imageUrl);
    notifyListeners();
  }

  void addImageObject(String title, String imageUrl, int id, int imageNumber) {
    if (title.isNotEmpty && imageUrl.isNotEmpty) {
      final newObject = ImageClass(
        imageUrl: imageUrl,
        title: title,
        id: id,
        imageNumber: imageNumber,
      );
      _objectImageList.add(newObject);
      notifyListeners();
    }
  }
}
