import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<LoginEventSubmit>((event, emit) {
      print("${_usernameController.text}, ${_passwordController.text}");
    });

    on<LoginEventRegister>((event, emit) {

    });
  }
}
