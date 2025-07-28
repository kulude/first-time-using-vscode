//import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_class.dart';
import 'package:uuid/uuid.dart';

final List<ImageClass> imageObjects = List.generate(imageList.length, (index) {
  final uuid = Uuid();
  return ImageClass(
    imageUrl: imageList[index],
    title: 'Image ${index + 1}',
    id: uuid.v4(),
    imageNumber: index + 1,
  );
});
