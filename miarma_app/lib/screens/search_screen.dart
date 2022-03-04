import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/blocs/bloc_posts/post_bloc.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/post_repositoryImpl.dart';
import 'package:miarma_app/resources/repository_post.dart';
import 'package:miarma_app/ui/widgets/error_page.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late RepositoryPost postRepository;
  late TabController tab;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
    tab = TabController(length: 1, vsync: this);
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
                            itemCount: posts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey,
                                          child: Container(
                                            child: Image(
                                                image: NetworkImage(posts[index]
                                                    .documentResized!
                                                    .replaceAll('localhost',
                                                        '10.0.2.2')),
                                                fit: BoxFit.cover),
                                          )),
                                    ),
                                  ],
                                ),
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
