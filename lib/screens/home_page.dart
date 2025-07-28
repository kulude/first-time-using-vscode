import 'package:flutter/material.dart';
import 'package:recipe_app/screens/google_page.dart';
import 'dart:math';
import 'package:recipe_app/screens/image_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _shuffle = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _shuffleImages() {
    var random = Random();
    setState(() {
      _shuffle = random.nextInt(6) + 1;
    });
  }

  String _imageUrl = 'assets/images/pexels-5.jpg';

  void _navigate(BuildContext context, String imageUrl) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => ImagePage(imageUrl: imageUrl)),
    );
    if (result != null) {
      setState(() {
        _imageUrl = result;
      });
    }
    print('Returned: ${result ?? 'nothing was returned'}');
  }

  @override
  void initState() {
    super.initState();
    _shuffleImages(); // Initialize with a random image on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // final String? resilt = await Navigator.push<String>(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ImagePage(
                //       imageUrl: 'assets/images/pexels-$_shuffle.jpg',
                //     ),
                //   ),
                // );
                // setState(() {
                //   _imageUrl = resilt ?? 'assets/images/pexels-$_shuffle.jpg';
                // });
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //       'Returned: ${resilt ?? 'nothing was returned'}',
                //     ),
                //   ),
                // );
                _navigate(context, 'assets/images/pexels-$_shuffle.jpg');
              },
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/pexels-$_shuffle.jpg'),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 100,
                    width: 90,
                    child: Image.asset(
                      'assets/images/pexels-${_imageUrl.split('-').last}',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                TextButton(onPressed: _shuffleImages, child: Text('shuffle')),
                SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GooglePage()),
                    );
                  },
                  child: Text('To google page'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('shuffle: $_shuffle'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
