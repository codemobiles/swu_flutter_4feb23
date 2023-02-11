part of 'login_bloc.dart';

enum LoginStatus { fetching, success, failed, init }

class LoginState extends Equatable {
  final LoginStatus status = LoginStatus.init;

  const LoginState();

  @override
  List<Object> get props => [];
}
