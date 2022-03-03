import 'package:miarma_app/models/auth/login_dto.dart';
import 'package:miarma_app/models/auth/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
