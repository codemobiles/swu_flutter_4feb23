part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState(this.currentPosition);
  final LatLng currentPosition;

  @override
  List<Object> get props => [currentPosition];
}
