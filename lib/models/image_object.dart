//import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_class.dart';

final List<ImageClass> imageObjects = List.generate(imageList.length, (index) {
  return ImageClass(
    imageUrl: imageList[index],
    title: 'Image ${index + 1}',
    id: index + 1,
    imageNumber: index + 1,
  );
});
