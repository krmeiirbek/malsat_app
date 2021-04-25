import 'package:flutter/material.dart';
import 'package:malsat_app/constants/custom_icons.dart';

import 'components/body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cIndex,
        onTap: (value) {
          setState(() {
            cIndex = value;
          });
        },
        selectedItemColor: Color(0xFFEA5E3C),
        unselectedItemColor: Color(0xFFBBBBBB),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Custom.home,
                size: 18.0,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Custom.heart_empty,
                size: 18.0,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
                size: 40.0,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Custom.comment,
                size: 18.0,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Custom.user,
                size: 18.0,
              ),
              label: ''),
        ],
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0,
  );
}
