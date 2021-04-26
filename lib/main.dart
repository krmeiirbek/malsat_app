import 'package:flutter/material.dart';
import 'package:malsat_app/pages/auth.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthSwitch(),
    );
  }
}
