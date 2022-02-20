import 'package:flutter/material.dart';

class User {
  final String name;
  final String username;
  final String image;
  bool isFollowedByMe;

  User(this.name, this.username, this.image, this.isFollowedByMe);
}

class FollowsScreen extends StatefulWidget {
  const FollowsScreen({Key? key}) : super(key: key);

  @override
  _FollowsScreenState createState() => _FollowsScreenState();
}

class _FollowsScreenState extends State<FollowsScreen>
    with TickerProviderStateMixin {
  List<User> _users = [
    User(
        'Elliana Palacios',
        '@elliana',
        'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
        false),
    User(
        'Kayley Dwyer',
        '@kayley',
        'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
        false),
    User(
        'Kathleen Mcdonough',
        '@kathleen',
        'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
        false),
    User(
        'Kathleen Dyer',
        '@kathleen',
        'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
        false),
    User(
        'Mikayla Marquez',
        '@mikayla',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false)
  ];

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Siguiendo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Expanded(
          child: AnimatedList(
              key: listKey,
              initialItemCount: _users.length,
              itemBuilder: (context, index, animation) {
                return userComponent(
                    user: _users[index], index: index, animation: animation);
              }),
        ),
      ),
    );
  }

  selectedUsersComponent({required User user, index, animation}) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(right: 20),
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            Positioned(
              top: 0,
              right: 15,
              child: GestureDetector(
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle,
                      color: Colors.grey[200]),
                  child: Center(
                      child: Icon(
                    Icons.close,
                    size: 18,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  userComponent({required User user, index, animation}) {
    return GestureDetector(
      child: FadeTransition(
        opacity: animation,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.image),
                    )),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(user.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(user.username,
                      style: TextStyle(color: Colors.grey[600])),
                ])
              ])
            ],
          ),
        ),
      ),
    );
  }
}
