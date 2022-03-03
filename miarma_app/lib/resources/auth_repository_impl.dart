import 'dart:convert';
import 'package:http/http.dart';
import 'package:miarma_app/models/auth/login_dto.dart';
import 'package:miarma_app/models/auth/login_response.dart';
import 'package:miarma_app/resources/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'
    };

    final response =
        await Future.delayed(const Duration(milliseconds: 4000), () {
      return _client.post(Uri.parse('http://10.0.2.2:8080/auth/login'),
          headers: headers, body: jsonEncode(loginDto.toJson()));
    });
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
