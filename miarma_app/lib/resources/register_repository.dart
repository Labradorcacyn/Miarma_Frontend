import 'package:miarma_app/models/register/register_dto.dart';
import 'package:miarma_app/models/register/register_model.dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register(RegisterDTO registerDTO);
}
