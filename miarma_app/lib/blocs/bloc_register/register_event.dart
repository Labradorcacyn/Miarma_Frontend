part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class DoRegisterEvent extends RegisterEvent {
  final RegisterDTO registerDTO;
  final String path;

  const DoRegisterEvent(this.registerDTO, this.path);
}
