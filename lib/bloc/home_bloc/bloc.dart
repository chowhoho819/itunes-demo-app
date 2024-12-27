library;

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itune_test_app/model/itune_res.dart';
import 'package:itune_test_app/repository/itune_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../main.dart';
import '../../model/music.dart';

part 'event.dart';
part 'state.dart';

// added this to avoid race issue, and to avoid calling same event at a very small margin of time.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

final emptyState = HomeState(status: HomeStatus.empty, musics: [], recordCount: 0, sortIndicator: SortState.emptyState);
final loadingState = HomeState(status: HomeStatus.loading, musics: [], recordCount: 0, sortIndicator: SortState.emptyState);
final failureState = HomeState(status: HomeStatus.failure, musics: [], recordCount: 0, sortIndicator: SortState.emptyState);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late ItuneRepository ituneRepository;
  late List<Music> cachedMusic;
  late int cachedMusicCount;

  HomeBloc() : super(loadingState) {
    on<HomeInitialEvent>(init);
    on<HomeFetchEvent>(fetchSong, transformer: throttleDroppable(Duration(milliseconds: 100)));
    on<HomeSearchEvent>(onSearchingSong, transformer: throttleDroppable(Duration(milliseconds: 50)));
    on<HomeSortEvent>(onSortSong);
  }

  Future<void> init(HomeInitialEvent event, Emitter<HomeState> emit) async {
    talker.debug("[Init Bloc Home Bloc]");
    ituneRepository = ItuneRepository();
    await fetchSong(HomeFetchEvent(limit: 200), emit);
  }

  /// Fetch Itune Song, path parameter is for testing that with empty result response
  /// (path parameter will be deleted when merging into main).
  Future<void> fetchSong(HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(loadingState); // trigger loading
    try {
      await Future.delayed(Duration(seconds: 2));
      ItuneResponse temp = await ituneRepository.getSongs(path: event.path, limit: event.limit);
      if (temp.resultCount > 0) {
        cachedMusic = temp.results ?? [];
        cachedMusicCount = temp.resultCount;
        emit(state.copyWith(musics: cachedMusic, status: HomeStatus.success, recordCount: cachedMusicCount));
        return;
      } else {
        emit(emptyState);
        return;
      }
    } catch (e) {
      emit(failureState);
      return;
    }
  }

  /// Search Song by Search Text.
  Future<void> onSearchingSong(HomeSearchEvent event, Emitter<HomeState> emit) async {
    if (event.searchText.isEmpty) {
      emit(state.copyWith(status: HomeStatus.success, musics: cachedMusic, recordCount: cachedMusicCount));
      return;
    }
    String searchText = event.searchText.trim().toLowerCase();
    if (cachedMusic.isNotEmpty) {
      final searchedSongs = cachedMusic.where((song) {
        return (song.trackName?.toLowerCase().contains(searchText) == true || song.collectionName?.toLowerCase().contains(searchText) == true);
      }).toList();
      if (searchedSongs.isNotEmpty) {
        emit(state.copyWith(status: HomeStatus.success, musics: searchedSongs, recordCount: searchedSongs.length, sortIndicator: SortState.emptyState));
      } else {
        emit(emptyState);
      }
    } else {
      emit(emptyState);
    }
  }

  Future<void> onSortSong(HomeSortEvent event, Emitter<HomeState> emit) async {
    if (event.sortState.album == SortStatus.empty && event.sortState.song == SortStatus.empty) {
      emit(state.copyWith(musics: cachedMusic, sortIndicator: SortState.emptyState));
    } else {
      final sortedList = event.sortState.sortWith(state.musics);
      emit(state.copyWith(musics: sortedList, sortIndicator: event.sortState));
    }
  }
}
