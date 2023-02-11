part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEventSubmit extends LoginEvent {
  final String username;
  final String password;

  LoginEventSubmit(this.username, this.password);
}

class LoginEventRegister extends LoginEvent {}
