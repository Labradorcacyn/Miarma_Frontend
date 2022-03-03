import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miarma_app/models/register/register_dto.dart';
import 'package:miarma_app/models/register/register_model.dart';
import 'package:miarma_app/resources/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

  void _doRegisterEvent(
      DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final registerResponse =
          await registerRepository.register(event.registerDTO, event.path);
      emit(RegisterSuccessState(registerResponse));
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
