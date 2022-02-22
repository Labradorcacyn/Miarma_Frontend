import 'dart:async';
import 'post_repositoryImpl.dart';
import '../models/post_model.dart';

class RepositoryPost {
  final postRepositoryImpl = PostRepositoryImpl();

  Future<List<PostModel>> fetchAllPost() => postRepositoryImpl.fetchAllPost();
}
