part of 'home_bloc.dart';

class HomeState extends Equatable {
  final YoutubeResponse youtubeResponse;

  const HomeState({required this.youtubeResponse});

  HomeState copyWith({YoutubeResponse? youtubeResponse}) {
    return HomeState(youtubeResponse: youtubeResponse ?? this.youtubeResponse);
  }

  @override
  List<Object> get props => [youtubeResponse];
}
