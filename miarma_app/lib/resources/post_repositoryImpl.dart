import 'dart:convert';
import 'package:http/http.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/repository_post.dart';

import '../utils/constant.dart';
import '../utils/preferences.dart';

class PostRepositoryImpl extends RepositoryPost {
  final Client _client = Client();

  @override
  Future<List<PostModel>> fetchAllPost() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString(Constants.token)}'
    };
    final response = await _client.get(
      Uri.parse('${Constants.apiBaseUrl}/post/public'),
      headers: headers,
    );

    if (response.statusCode == 201) {
      return List.from(json
          .decode(response.body)
          .map((e) => PostModel.fromJson(e))
          .toList());
    } else {
      throw Exception('Fail to load posts');
    }
  }
}
