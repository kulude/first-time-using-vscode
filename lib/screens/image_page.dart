import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_object.dart';

class ImagePage extends StatefulWidget {
  final String imageUrl;

  const ImagePage({super.key, required this.imageUrl});
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final String _defaultImage = 'assets/images/pexels-1.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Page')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 300, maxWidth: 200),
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: Center(
                        child: Icon(Icons.error, color: Colors.red, size: 30),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop<String>(context, _defaultImage);
                  print('browser back pressed');
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: imageObjects.length,
              itemBuilder: (context, index) {
                final imageObject = imageObjects[index];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.asset(
                          imageObject.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              imageObject.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${imageObject.imageNumber}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
