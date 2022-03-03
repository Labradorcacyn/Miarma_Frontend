import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/blocs/bloc_posts/post_bloc.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/post_repositoryImpl.dart';
import 'package:miarma_app/resources/repository_post.dart';
import 'package:miarma_app/ui/widgets/error_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RepositoryPost postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
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

  _createPostView(BuildContext context, List<PostModel> posts) {
    return SizedBox(
      height: 800,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "MiarmaApp",
                  style: TextStyle(fontSize: 30, color: Colors.purple),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => print('Agregar Publicación'),
                      iconSize: 20,
                      icon: Icon(FontAwesomeIcons.plus),
                      color: Colors.purple,
                    ),
                    IconButton(
                      onPressed: () => print('Ver interacciones'),
                      iconSize: 20,
                      icon: Icon(FontAwesomeIcons.heart),
                      color: Colors.purple,
                    ),
                    IconButton(
                      onPressed: () => print('Ver mensajes'),
                      iconSize: 20,
                      icon: Icon(FontAwesomeIcons.envelope),
                      color: Colors.purple,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0, 2),
                                blurRadius: 6.0)
                          ]),
                      child: CircleAvatar(
                          child: ClipOval(
                              child: Image(
                                  height: 60,
                                  width: 60,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoHYtXTchhspak0O8PNPKAPD9Cf08U6284ng&usqp=CAU'),
                                  fit: BoxFit.cover))));
                }),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 610,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    child: ClipOval(
                                        child: Image(
                                            height: 60,
                                            width: 60,
                                            image: NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoHYtXTchhspak0O8PNPKAPD9Cf08U6284ng&usqp=CAU'),
                                            fit: BoxFit.cover))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(posts[index].title.toString()),
                              ),
                            ],
                          ),
                          Image(
                              height: 500,
                              width: double.infinity,
                              image: NetworkImage(
                                  'https://static.eldiario.es/clip/71d118ff-5ef2-449c-be8a-6c321304fa70_16-9-aspect-ratio_default_0.jpg'),
                              fit: BoxFit.cover),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () => print("Like post"),
                                      icon: Icon(FontAwesomeIcons.solidHeart)),
                                  Text("450")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () => print("Comments"),
                                      icon: Icon(FontAwesomeIcons.envelope)),
                                  Text("45")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
