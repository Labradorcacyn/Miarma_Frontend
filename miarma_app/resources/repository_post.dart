import 'dart:async';
import 'miarma_api_provider.dart';
import '../models/post_model.dart';

class RepositoryPost {
  final miarmaApiProvider = MiarmaApiProvider();

  Future<PostModel> fetchAllPost() => miarmaApiProvider.fetchPostList();
}
