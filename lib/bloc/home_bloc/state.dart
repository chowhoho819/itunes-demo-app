part of 'bloc.dart';

enum HomeStatus { loading, success, empty, failure }

final class HomeState extends Equatable {
  final List<Music> musics;
  final HomeStatus status;
  final int recordCount;

  const HomeState({required this.musics, required this.status, required this.recordCount});

  @override
  List<Object?> get props => [musics, status];

  HomeState copyWith({
    List<Music>? musics,
    HomeStatus? status,
    int? recordCount,
  }) {
    return HomeState(
      musics: musics ?? this.musics,
      status: status ?? this.status,
      recordCount: recordCount ?? this.recordCount,
    );
  }
}
