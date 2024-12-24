import 'package:flutter_test/flutter_test.dart';
import 'package:itune_test_app/repository/itune_repository.dart';
import 'package:itune_test_app/utils/dio_client.dart';

void main() {
  late ItuneRepository ituneRepository;
  setUp(() {
    DioClient().create();
    ituneRepository = ItuneRepository();
  });
  group("Repository Test", () {
    test('getSongs returns ItuneResponse on success', () async {
      expect(() async => await ituneRepository.getSongs(limit: 1), isNotNull);
    });
    test('getSongs returns exception when ltimit input is 0', () async {
      expect(() async => await ituneRepository.getSongs(limit: 0), throwsA(isA<AssertionError>()));
    });
  });
}
