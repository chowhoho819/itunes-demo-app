library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itune_test_app/model/itune_res.dart';
import 'package:itune_test_app/repository/itune_repository.dart';

import '../../main.dart';
import '../../model/music.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late ItuneRepository ituneRepository;
  HomeBloc() : super(const HomeState(status: HomeStatus.loading, musics: [], recordCount: 0)) {
    on<HomeInitialEvent>(init);
    on<HomeFetchEvent>(fetchSong);
  }

  Future<void> init(HomeInitialEvent event, Emitter<HomeState> emit) async {
    talker.debug("[Init Bloc Home Bloc]");
    ituneRepository = ItuneRepository();
    await fetchSong(HomeFetchEvent(limit: 200), emit);
  }

  /// Fetch Itune Song, path parameter is for testing that with empty result response
  /// (path parameter will be deleted when merging into main).
  Future<void> fetchSong(HomeFetchEvent event, Emitter<HomeState> emit) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      ItuneResponse temp = await ituneRepository.getSongs(path: event.path, limit: event.limit);
      if (temp.resultCount > 0) {
        emit(HomeState(musics: temp.results ?? [], status: HomeStatus.success, recordCount: temp.resultCount));
      } else {
        emit(HomeState(musics: temp.results ?? [], status: HomeStatus.empty, recordCount: 0));
      }
    } catch (e) {
      emit(HomeState(musics: [], status: HomeStatus.failure, recordCount: 0));
    }
  }
}
