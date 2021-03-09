import 'package:flutter/material.dart';
import 'package:flutter_for_nasa/locator.dart';
import 'package:flutter_for_nasa/views/MyHomePage.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA Exoplanet Viewer',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'NASA Exoplanet Archive Viewer'),
    );
  }
}
