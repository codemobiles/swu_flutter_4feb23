part of 'login_bloc.dart';

enum LoginStatus { fetching, success, failed, init }

class LoginState extends Equatable {
  final LoginStatus status;

  LoginState({
    this.status = LoginStatus.init,
  });

  LoginState copyWith({LoginStatus? status}){
    return LoginState(status: status ?? this.status);
}

  @override
  List<Object> get props => [status];
}
