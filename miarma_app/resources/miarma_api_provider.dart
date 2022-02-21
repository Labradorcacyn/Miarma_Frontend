import 'dart:async';
import 'package:http/http.dart' show Client;
import '../models/post_model.dart';
import 'dart:convert';

class MiarmaApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<PostModel> fetchPostList() async {
    print("entered");
    final response = await client.get("http://localhost:8080/post/public");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
