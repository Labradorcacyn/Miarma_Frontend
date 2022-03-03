import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:miarma_app/models/register/register_dto.dart';
import 'package:miarma_app/models/register/register_model.dart';
import 'package:miarma_app/resources/register_repository.dart';
import 'package:miarma_app/utils/preferences.dart';
import '../utils/constant.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<RegisterResponse> register(
      RegisterDTO registerDTO, String path) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    final uri = Uri.parse('${Constants.apiBaseUrl}/auth/register');

    final body = jsonEncode({
      'avatar': "",
      'fullname': registerDTO.fullname,
      'email': registerDTO.email,
      'password': registerDTO.password,
      'password2': registerDTO.password2,
      'visibilidad': registerDTO.privacy,
      'fechaNacimiento': registerDTO.birthday.toString().split(' ')[0]
    });

    PreferenceUtils.setString('avatar', path);

    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('nuevoUsuario', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', path,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll(headers);

    final res = await request.send();

    final responded = await http.Response.fromStream(res);

    if (res.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(responded.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
