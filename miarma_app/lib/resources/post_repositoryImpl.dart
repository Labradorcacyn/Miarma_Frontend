import 'dart:convert';
import 'package:http/http.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/repository_post.dart';

class PostRepositoryImpl extends RepositoryPost {
  final Client _client = Client();

  @override
  Future<List<PostModel>> fetchAllPost() async {
    final response =
        await _client.get(Uri.parse('http://localhost:8080/post/public'));
    if (response.statusCode == 200) {
      return List.from(json
          .decode(response.body)
          .map((e) => PostModel.fromJson(e))
          .toList());
    } else {
      throw Exception('Fail to load posts');
    }
  }
}
