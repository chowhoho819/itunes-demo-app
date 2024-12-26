part of 'bloc.dart';

enum HomeStatus { loading, success, empty, failure }

final class HomeState extends Equatable {
  final List<Music> musics;
  final HomeStatus status;
  final int recordCount;
  final int sortStatus;
  /* sort status 
  0: No Sorting
  1: Ascsending Order
  2: Descending Order
  */

  const HomeState({required this.musics, required this.status, required this.recordCount, required this.sortStatus});

  @override
  List<Object?> get props => [musics, status];

  HomeState copyWith({
    List<Music>? musics,
    HomeStatus? status,
    int? recordCount,
    int? sortStatus,
  }) {
    return HomeState(
      musics: musics ?? this.musics,
      status: status ?? this.status,
      recordCount: recordCount ?? this.recordCount,
      sortStatus: sortStatus ?? this.sortStatus,
    );
  }
}
