import 'package:flutter/material.dart';
import 'package:recipe_app/responsive.dart/desktop_layout.dart';
import 'package:recipe_app/responsive.dart/responsive_layout.dart';
import 'package:recipe_app/screens/home_page.dart';

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
      home: ResponsiveLayout(
        mobileBody: MyHomePage(title: 'My home page'),
        desktopBody: DesktopLayout(imageUrl: 'assets/images/pexels-1.jpg'),
      ),
    );
  }
}
