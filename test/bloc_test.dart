import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';
import 'package:itune_test_app/utils/dio_client.dart';
import 'package:mockito/mockito.dart';
import 'package:itune_test_app/repository/itune_repository.dart';
import 'package:itune_test_app/model/music.dart';

// Mock class for ItuneRepository
class MockItuneRepository extends Mock implements ItuneRepository {}

void main() {
  late HomeBloc homeBloc;
  late MockItuneRepository mockItuneRepository;
  const expectedResult = {
    "wrapperType": "track",
    "kind": "song",
    "artistId": 159260351,
    "collectionId": 1468058165,
    "trackId": 1468058704,
    "artistName": "Taylor Swift",
    "collectionName": "Lover",
    "trackName": "You Need To Calm Down",
    "collectionCensoredName": "Lover",
    "trackCensoredName": "You Need To Calm Down",
    "artistViewUrl": "https://music.apple.com/us/artist/taylor-swift/159260351?uo=4",
    "collectionViewUrl": "https://music.apple.com/us/album/you-need-to-calm-down/1468058165?i=1468058704&uo=4",
    "trackViewUrl": "https://music.apple.com/us/album/you-need-to-calm-down/1468058165?i=1468058704&uo=4",
    "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/85/05/a9/8505a97c-15ff-f665-fec4-f6bf59e5b0fa/mzaf_5253572336075386160.plus.aac.p.m4a",
    "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/49/3d/ab/493dab54-f920-9043-6181-80993b8116c9/19UMGIM53909.rgb.jpg/30x30bb.jpg",
    "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/49/3d/ab/493dab54-f920-9043-6181-80993b8116c9/19UMGIM53909.rgb.jpg/60x60bb.jpg",
    "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/49/3d/ab/493dab54-f920-9043-6181-80993b8116c9/19UMGIM53909.rgb.jpg/100x100bb.jpg",
    "collectionPrice": 11.99,
    "trackPrice": 1.29,
    "releaseDate": "2019-06-14T07:00:00Z",
    "collectionExplicitness": "notExplicit",
    "trackExplicitness": "notExplicit",
    "discCount": 1,
    "discNumber": 1,
    "trackCount": 18,
    "trackNumber": 14,
    "trackTimeMillis": 171352,
    "country": "USA",
    "currency": "USD",
    "primaryGenreName": "Pop",
    "isStreamable": true
  };

  setUp(() {
    mockItuneRepository = MockItuneRepository();
    DioClient().create();
    homeBloc = HomeBloc()..ituneRepository = mockItuneRepository; // Inject the mock
  });

  tearDown(() {
    homeBloc.close(); // Close the bloc after each test
  });

  group('HomeBloc', () {
    test('initial state is correct', () {
      expect(homeBloc.state, HomeState(status: HomeStatus.loading, musics: [], recordCount: 0, sortIndicator: SortState.emptyState));
    });

    blocTest<HomeBloc, HomeState>(
      'emits [loading, success] when songs are fetched successfully',
      build: () => homeBloc..add(HomeInitialEvent()),
      act: (bloc) => bloc.add(HomeFetchEvent(limit: 1)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        HomeState(status: HomeStatus.loading, musics: [], recordCount: 0, sortIndicator: SortState.emptyState),
        HomeState(status: HomeStatus.success, musics: [Music.fromJson(expectedResult)], recordCount: 1, sortIndicator: SortState.emptyState),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, failure] when songs fetch fails',
      build: () => homeBloc..add(HomeInitialEvent()),
      act: (bloc) => bloc.add(HomeFetchEvent(limit: 0)),
      expect: () => [
        HomeState(status: HomeStatus.loading, musics: [], recordCount: 0, sortIndicator: SortState.emptyState),
        HomeState(status: HomeStatus.failure, musics: [], recordCount: 0, sortIndicator: SortState.emptyState),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, empty] when songs fetch empty',
      build: () => homeBloc..add(HomeInitialEvent()),
      act: (bloc) => bloc.add(HomeFetchEvent(limit: 1, path: "https://itunes.apple.com/search?term=xfdsdfsdf&limit=1&media=music")),
      wait: Duration(milliseconds: 500),
      expect: () => [
        HomeState(status: HomeStatus.loading, musics: [], recordCount: 0, sortIndicator: SortState.emptyState),
        HomeState(status: HomeStatus.empty, musics: [], recordCount: 0, sortIndicator: SortState.emptyState),
      ],
    );
  });
}
