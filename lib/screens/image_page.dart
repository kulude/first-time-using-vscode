import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_object.dart';

class ImagePage extends StatefulWidget {
  final String imageUrl;

  const ImagePage({super.key, required this.imageUrl});
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: imageObjects.length,
            itemBuilder: (context, index) {
              final imageObject = imageObjects[index];
              return Stack(
                children: [
                  Container(
                    height: 200,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Image.asset(imageObject.imageUrl),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(imageObject.title),
                          SizedBox(height: 4),
                          Text('${imageObject.imageNumber}'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 300,
              width: 200,
              child: Image.asset(widget.imageUrl, fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
