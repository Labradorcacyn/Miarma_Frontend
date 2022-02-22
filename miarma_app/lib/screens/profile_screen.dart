import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/screens/follower_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tab;
  List fotos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  void initState() {
    super.initState();
    tab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey[100],
            title: Container(
                color: Colors.grey[100],
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Miarma App",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Seguidores",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.purple)),
                            ),
                            Text("Siguiendo",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.purple))
                          ],
                        ))
                  ],
                )),
          ),
          SliverAppBar(
            backgroundColor: Colors.grey[100],
            pinned: true,
            title: Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(controller: tab, tabs: [
                Tab(
                    icon: Icon(FontAwesomeIcons.photoVideo,
                        color: Colors.purple)),
                Tab(icon: Icon(FontAwesomeIcons.video, color: Colors.purple)),
                Tab(icon: Icon(FontAwesomeIcons.userTag, color: Colors.purple)),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: TabBarView(
                    controller: tab,
                    children: [
                      Container(
                          child: GridView.builder(
                        itemCount: fotos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey,
                                  child: Text('$index'),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                      Container(
                          child: GridView.builder(
                        itemCount: fotos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey,
                                  child: Text('$index'),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                      Container(
                          child: GridView.builder(
                        itemCount: fotos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey,
                                  child: Text('$index'),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                    ],
                  ),
                  height: 600,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
