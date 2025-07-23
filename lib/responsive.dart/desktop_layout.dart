import 'package:flutter/material.dart';
import 'package:recipe_app/models/image_object.dart';

class DesktopLayout extends StatefulWidget {
  final String imageUrl;

  const DesktopLayout({super.key, required this.imageUrl});
  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Page')),
      body: Column(
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
                      child: Positioned.fill(
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
                            ),
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
          ),
        ],
      ),
    );
  }
}
