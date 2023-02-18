import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/youtube_response.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEventLoadData>((event, emit) async {
      final dio = Dio();
      final url = "https://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=songs";
      final response  = await dio.get(url);
      final youtubeResponse  = youtubeResponseFromJson(response.data);
      emit(state.copyWith(youtubes: youtubeResponse.youtubes));
    });


  }
}
