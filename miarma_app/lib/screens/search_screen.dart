import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/screens/follower_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController tab;
  List fotos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  @override
  void initState() {
    super.initState();
    tab = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.search,
                              color: Colors.purple,
                            ),
                            border: InputBorder.none,
                            hintText: "Buscar"),
                      ),
                    ),
                    Container(
                      child: TabBarView(
                        controller: tab,
                        children: [
                          Container(
                              child: GridView.builder(
                            itemCount: fotos.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                  ],
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
