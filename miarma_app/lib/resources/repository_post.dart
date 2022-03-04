import 'dart:async';
import 'post_repositoryImpl.dart';
import '../models/post_model.dart';

abstract class RepositoryPost {
  Future<List<PostModel>> fetchAllPost();
}
