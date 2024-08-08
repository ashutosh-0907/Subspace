import 'package:flutter/material.dart';
import 'package:subspace/model/bloc_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlogScreen(),
    );
  }
}
