part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.currentPosition,
    this.allLocations,
  });

  final LatLng? currentPosition;
  final List<Position>? allLocations;

  MapState copyWith({
    LatLng? currentPosition,
    List<Position>? allLocations,
  }) {
    return MapState(
      currentPosition: currentPosition ?? this.currentPosition,
      allLocations: allLocations ?? this.allLocations,
    );
  }

  @override
  List<Object> get props => [
        currentPosition ?? LatLng(0, 0),
        allLocations ?? [],
      ];
}
