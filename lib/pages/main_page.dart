import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('MALSAT'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'hello',
          ),
        ),
      ),
    );
  }
}
