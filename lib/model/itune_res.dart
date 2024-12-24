// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'music.dart';

part 'itune_res.freezed.dart';
part 'itune_res.g.dart';

@freezed
class ItuneResponse with _$ItuneResponse {
  factory ItuneResponse({
    @JsonKey(name: 'resultCount') required int resultCount,
    @JsonKey(name: 'results') List<Music>? results,
  }) = _ItuneResponse;

  factory ItuneResponse.fromJson(Map<String, dynamic> json) => _$ItuneResponseFromJson(json);
}
