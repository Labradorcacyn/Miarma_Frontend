import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Icon(FontAwesomeIcons.plusCircle)), //Logo de la App
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.plusCircle),
                      Icon(FontAwesomeIcons.userFriends),
                      Icon(FontAwesomeIcons.circle), //ImageIcon Foto Perfil
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
