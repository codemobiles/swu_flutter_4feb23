import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/LocationResponse.dart';
import 'package:demo0/src/services/network_service.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(currentPosition: LatLng(13.7462463, 100.5325515))) {
    // submit
    on<MapEvent_SubmitLocation>((event, emit) async {
      emit(state.copyWith(currentPosition: event.position));
      NetworkService().submitLocation(event.position);
    });

    // load
    on<MapEvent_LoadLocation>((event, emit) async {
      final result = await NetworkService().loadLocations();
      if (result != null) {
        emit(state.copyWith(allLocations: result.positions));
      }
    });
  }
}
