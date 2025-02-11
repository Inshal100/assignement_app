part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool loginState;
  LoginState({this.loginState = true});

  LoginState copyWith(bool? loginState) {
    return LoginState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object> get props => [loginState];
}
