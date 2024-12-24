part of 'bloc.dart';

enum HomeStatus { loading, success, empty, failure }

final class HomeState extends Equatable {
  final List<Music> musics;
  final HomeStatus status;

  const HomeState({required this.musics, required this.status});

  @override
  List<Object?> get props => [musics, status];

  HomeState copyWith({
    List<Music>? musics,
    HomeStatus? status,
  }) {
    return HomeState(
      musics: musics ?? this.musics,
      status: status ?? this.status,
    );
  }
}
