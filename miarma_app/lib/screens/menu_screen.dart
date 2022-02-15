import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/screens/home_screen.dart';
import 'package:miarma_app/screens/profile_screen.dart';
import 'package:miarma_app/screens/search_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int index = 1;

  final screens = [HomeScreen(), ProfileScreen(), SearchScreen()];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(FontAwesomeIcons.home, size: 20),
      Icon(FontAwesomeIcons.user, size: 20),
      Icon(FontAwesomeIcons.search, size: 20)
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.purple.shade100,
          color: Colors.purple,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: items,
          index: 1,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
