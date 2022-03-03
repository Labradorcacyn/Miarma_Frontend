import 'package:flutter/material.dart';
import 'package:miarma_app/screens/home_screen.dart';
import 'package:miarma_app/screens/profile_screen.dart';
import 'package:miarma_app/screens/search_screen.dart';
import 'package:miarma_app/utils/constant.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [HomeScreen(), SearchScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: MediaQuery.of(context).padding,
            child: pages[_currentIndex]),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
          ),
        )),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.purple
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Colors.purple
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _currentIndex == 2
                              ? Colors.black
                              : Colors.transparent,
                          width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(Constants.avatar
                              .toString()
                              .replaceFirst('localhost', '10.0.2.2')))),
                ))
          ],
        ));
  }
}
