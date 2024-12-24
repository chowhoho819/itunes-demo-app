import 'package:itune_test_app/model/itune_res.dart';
import 'package:itune_test_app/utils/dio_client.dart';

class ItuneRepository {
  DioClient client = DioClient();

  Future<void> getSongs({Map<String, dynamic>? queryParameters}) async {
    final path = "https://itunes.apple.com/search?term=Talyor+Swift&limit=10&media=music";
    await client.get<ItuneResponse>(path);
  }
}
