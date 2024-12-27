part of 'bloc.dart';

enum HomeStatus { loading, success, empty, failure }

final class HomeState extends Equatable {
  final List<Music> musics;
  final HomeStatus status;
  final int recordCount;
  final SortState sortIndicator;

  const HomeState({
    required this.musics,
    required this.status,
    required this.recordCount,
    required this.sortIndicator,
  });

  @override
  List<Object?> get props => [musics, status];

  HomeState copyWith({
    List<Music>? musics,
    HomeStatus? status,
    int? recordCount,
    SortState? sortIndicator,
  }) {
    return HomeState(
      musics: musics ?? this.musics,
      status: status ?? this.status,
      recordCount: recordCount ?? this.recordCount,
      sortIndicator: sortIndicator ?? this.sortIndicator,
    );
  }
}

enum SortStatus {
  asc(Icons.arrow_downward),
  desc(Icons.arrow_upward),
  empty(Icons.clear_all);

  const SortStatus(this.icon);
  final IconData icon;
}

class SortState {
  final SortStatus album;
  final SortStatus song;

  SortState({required this.album, required this.song});

  static SortState get emptyState => SortState(album: SortStatus.empty, song: SortStatus.empty);

  // Method to toggle the sorting status
  SortState toggleAlbumSort() {
    talker.debug(album);
    return SortState(
      album: _toggleSortStatus(album),
      song: song,
    );
  }

  SortState toggleSongSort() {
    talker.debug(song);
    return SortState(
      album: album,
      song: _toggleSortStatus(song),
    );
  }

  // Helper method to toggle sort status
  SortStatus _toggleSortStatus(SortStatus status) {
    switch (status) {
      case SortStatus.empty:
        return SortStatus.asc; // Default to ascending
      case SortStatus.asc:
        return SortStatus.desc; // Go to descending
      case SortStatus.desc:
        return SortStatus.empty; // Reset to empty
    }
  }

  List<Music> sortWith(List<Music> musics) {
    List<Music> temp = List.from(musics);

    // Album sorting
    switch (album) {
      case SortStatus.asc:
        temp.sort((a, b) => a.collectionName!.compareTo(b.collectionName!));
        break;
      case SortStatus.desc:
        temp.sort((b, a) => a.collectionName!.compareTo(b.collectionName!));
        break;
      case SortStatus.empty:
        break;
    }

    // Song sorting
    switch (song) {
      case SortStatus.asc:
        temp.sort((a, b) => a.trackName!.compareTo(b.trackName!));
        break;
      case SortStatus.desc:
        temp.sort((b, a) => a.trackName!.compareTo(b.trackName!));
        break;
      case SortStatus.empty:
        break;
    }
    return temp; // Return the sorted copy
  }
}
