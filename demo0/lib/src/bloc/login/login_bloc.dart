import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/user.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {

    on<LoginEventSubmit>((event, emit) {
      final username = event.payload.username;
      final password = event.payload.password;
      if (username == "admin" && password == "1234"){
        // success
        emit(state.copyWith(status: LoginStatus.success));
      }else{
        // failed
        emit(state.copyWith(status: LoginStatus.failed));
      }

    });

    on<LoginEventRegister>((event, emit) {
      print("${event.payload.username}, ${event.payload.password}");
    });
  }
}
