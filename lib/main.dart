import 'package:flutter/material.dart';
import 'package:timevisualer/views/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Visualer',
      home: Home(),
    );
  }
}