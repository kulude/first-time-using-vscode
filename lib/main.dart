import 'package:flutter/material.dart';
import 'dart:math';
import 'package:recipe_app/screens/image_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

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

  void _navigate(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImagePage(imageUrl: imageUrl)),
    );
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
                _navigate('assets/images/pexels-$_shuffle.jpg');
              },
              child: SizedBox(
                height: 100,
                width: 90,
                child: Image.asset('assets/images/pexels-$_shuffle.jpg'),
              ),
            ),
            SizedBox(height: 50),
            TextButton(onPressed: _shuffleImages, child: Text('shuffle')),
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
