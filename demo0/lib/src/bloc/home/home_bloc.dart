import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/youtube_response.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEventLoadData>((event, emit) {

    });
  }
}
