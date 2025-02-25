import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<ChangeMethod>(_changeState);
  }
  void _changeState(ChangeMethod event, Emitter<LoginState> emit) {
    emit(state.copyWith(!state.loginState));
  }
}
