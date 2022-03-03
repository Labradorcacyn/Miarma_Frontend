import 'dart:convert';
import 'package:http/http.dart';
import 'package:miarma_app/models/post_model.dart';
import 'package:miarma_app/resources/repository_post.dart';

class PostRepositoryImpl extends RepositoryPost {
  final Client _client = Client();

  @override
  Future<List<PostModel>> fetchAllPost() async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJjMGE4MzgwMS03ZjRhLTE0MDYtODE3Zi00YTQ0MjJiYjAwMDAiLCJpYXQiOjE2NDYzMDQ4NTksIm5vbWJyZSI6IlNlcmdpbyIsImFwZWxsaWRvcyI6IkNoYW1vcnJvIEdhcmPDrWEiLCJyb2wiOiJVU1VBUklPIn0.0z_FlanNEuse0NN3bMA50dlZfYiSphZqTeBI87T4MJv6_-M5P33yWCxCugC219RN'
    });
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
