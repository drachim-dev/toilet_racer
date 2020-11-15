import 'package:flutter/material.dart';
import 'package:toilet_racer/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const title = 'Toilet Racer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeView(title: title),
    );
  }
}