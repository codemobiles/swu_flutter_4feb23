part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Youtube> youtubes;
  HomeState({this.youtubes = []});

  HomeState copyWith({YoutubeResponse? youtubes}) {
    return HomeState(youtubes: youtubes ?? this.youtubes);
  }

  @override
  List<Object> get props => [youtubes];
}
