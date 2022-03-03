import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miarma_app/utils/constant.dart';
import 'package:miarma_app/utils/preferences.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
          ),
          BottomNavigationBarItem(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                File(PreferenceUtils.getString(Constants.avatar)!
                    .replaceAll('localhost', '10.0.2.2')),
                width: 30,
                height: 30,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        activeColor: Colors.black,
        onTap: _onItemTapped,
        border: const Border.fromBorderSide(BorderSide.none),
        iconSize: 28.0,
      ),
    );
  }
}
