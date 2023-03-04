part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.currentPosition,
    this.allLocations,
  });

  final LatLng? currentPosition;
  final List<Location>? allLocations;

  MapState copyWith({
    LatLng? currentPosition,
    List<Location>? allLocations,
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
