import 'package:flutter/material.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/screens/favorites_screen.dart';
import 'package:malsat_app/screens/home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      HomeScreen(),
      FavoritesScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
    super.initState();
  }

  List<IconData> icons = [
    Custom.home,
    Custom.heart_empty,
    Icons.add_circle_outline,
    Custom.comment,
    Custom.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BottomNavigationBar(
                backgroundColor: Colors.blueGrey,
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
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
            ),
          ),
        ),
      ),
    );
  }
}
