import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(LatLng(13.7462463, 100.5325515))) {
    on<MapEvent_SubmitLocation>((event, emit) async {
      print("Gonna submit: " + event.position.toString());

      // send
      final position = event.position;
      var params = {
        "lat": position.latitude,
        "lng": position.longitude,
      };

      Response response = await Dio().post(
        "http://172.20.10.9:3000/submit_location",
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(params),
      );

      print(response.data.toString());
    });
  }
}
