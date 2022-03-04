import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/blocs/bloc_posts/post_bloc.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/post_repositoryImpl.dart';
import 'package:miarma_app/resources/repository_post.dart';
import 'package:miarma_app/screens/follower_screen.dart';
import 'package:miarma_app/screens/follows_screen.dart';
import 'package:miarma_app/ui/widgets/error_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late RepositoryPost postRepository;
  late TabController tab;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
    tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PostBloc(postRepository)..add(const FetchPostsPublicEvent());
      },
      child: Scaffold(body: _listPosts(context)),
    );
  }

  _listPosts(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PostFetched) {
        return _createPostView(context, state.posts);
      } else if (state is PostFetchError) {
        return ErrorPage(
          message: state.message,
          retry: () {
            context.watch<PostBloc>().add(const FetchPostsPublicEvent());
          },
        );
      } else {
        return const Text('Not support');
      }
    });
  }

  @override
  Widget _createPostView(BuildContext context, List<PostModel> posts) {
    return Container(
      child: CustomScrollView(
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
                      flex: 2,
                      child: Image.asset("assets/images/logoColor.png"),
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Text("Followers",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.purple)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FollowerScreen()));
                                    },
                                  )),
                              InkWell(
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.purple),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FollowsScreen()));
                                },
                              )
                            ],
                          ),
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
                        itemCount: posts.length,
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
                                    child: Image(
                                        image: NetworkImage(posts[index]
                                            .documentResized!
                                            .replaceAll(
                                                'localhost', '10.0.2.2')),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          );
                        },
                      )),
                      Container(
                          child: GridView.builder(
                        itemCount: posts.length,
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
                                    child: Image(
                                        image: NetworkImage(posts[index]
                                            .documentResized!
                                            .replaceAll(
                                                'localhost', '10.0.2.2')),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          );
                        },
                      )),
                      Container(
                          child: GridView.builder(
                        itemCount: posts.length,
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
                                    child: Image(
                                        image: NetworkImage(posts[index]
                                            .documentResized!
                                            .replaceAll(
                                                'localhost', '10.0.2.2')),
                                        fit: BoxFit.cover)),
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
