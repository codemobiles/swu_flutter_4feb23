part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEventSubmit extends LoginEvent {
  final User payload;
  LoginEventSubmit(this.payload);
}

class LoginEventRegister extends LoginEvent {}
