import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/app.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/models/user.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEventSubmit>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.fetching));
      // delay for 1 sec.
      await Future.delayed(Duration(seconds: 1));
      final username = event.payload.username;
      final password = event.payload.password;
      if (username == "admin" && password == "1234") {
        // success
        emit(state.copyWith(status: LoginStatus.success));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(NetworkAPI.token, "1234214124");
      } else {
        // failed
        emit(state.copyWith(status: LoginStatus.failed));
      }
    });

    on<LoginEventRegister>((event, emit) {
      print("${event.payload.username}, ${event.payload.password}");
    });

    on<LoginEvent_Logout>((event, emit) async {
      print("Logout");
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      if (navigatorState.currentContext != null)
        Navigator.pushReplacementNamed(
          navigatorState.currentContext!,
          AppRoute.login,
        );
    });
  }
}
