import 'dart:convert';

import 'package:itune_test_app/model/itune_res.dart';
import 'package:itune_test_app/utils/dio_client.dart';

class ItuneRepository {
  DioClient client = DioClient();

  Future<ItuneResponse> getSongs({String? path, Map<String, dynamic>? queryParameters, int? limit}) async {
    if (limit != null) {
      assert(limit > 0);
    }
    try {
      limit ??= 200;
      final dPath = "https://itunes.apple.com/search?term=Talyor+Swift&limit=$limit&media=music";
      final data = await client.get(path ?? dPath);
      return ItuneResponse.fromJson(json.decode(data));
    } catch (e) {
      rethrow;
    }
  }
}
