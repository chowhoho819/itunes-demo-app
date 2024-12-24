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
  HomeBloc() : super(const HomeState(status: HomeStatus.loading, musics: [])) {
    on<HomeInitialEvent>(init);
    on<HomeFetchEvent>(fetchSong);
  }

  void init(HomeInitialEvent event, Emitter<HomeState> emit) async {
    talker.debug("[Init Bloc Home Bloc]");
    ituneRepository = ItuneRepository();
    emit(HomeState(musics: [], status: HomeStatus.loading));
  }

  /// Fetch Itune Song, path parameter is for testing that with empty result response
  /// (path parameter will be deleted when merging into main).
  void fetchSong(HomeFetchEvent event, Emitter<HomeState> emit) async {
    try {
      ItuneResponse temp = await ituneRepository.getSongs(path: event.path, limit: event.limit);
      if (temp.resultCount > 0) {
        emit(HomeState(musics: temp.results ?? [], status: HomeStatus.success));
      } else {
        emit(HomeState(musics: temp.results ?? [], status: HomeStatus.empty));
      }
    } catch (e) {
      emit(HomeState(musics: [], status: HomeStatus.failure));
    }
  }

  static BlocProvider get expose => BlocProvider(create: (context) => HomeBloc()..add(HomeInitialEvent()), lazy: false);
}
