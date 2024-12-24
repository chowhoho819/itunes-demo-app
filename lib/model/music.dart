// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'music.freezed.dart';
part 'music.g.dart';

@freezed
class Music with _$Music {
  const factory Music({
    @JsonKey(name: 'wrapperType') String? wrapperType,
    @JsonKey(name: 'kind') String? kind,
    @JsonKey(name: 'artistId') int? artistId,
    @JsonKey(name: 'collectionId') int? collectionId,
    @JsonKey(name: 'trackId') int? trackId,
    @JsonKey(name: 'artistName') String? artistName,
    @JsonKey(name: 'collectionName') String? collectionName,
    @JsonKey(name: 'trackName') String? trackName,
    @JsonKey(name: 'collectionCensoredName') String? collectionCensoredName,
    @JsonKey(name: 'trackCensoredName') String? trackCensoredName,
    @JsonKey(name: 'artistViewUrl') String? artistViewUrl,
    @JsonKey(name: 'collectionViewUrl') String? collectionViewUrl,
    @JsonKey(name: 'trackViewUrl') String? trackViewUrl,
    @JsonKey(name: 'previewUrl') String? previewUrl,
    @JsonKey(name: 'artworkUrl30') String? artworkUrl30,
    @JsonKey(name: 'artworkUrl60') String? artworkUrl60,
    @JsonKey(name: 'artworkUrl100') String? artworkUrl100,
    @JsonKey(name: 'collectionPrice') double? collectionPrice,
    @JsonKey(name: 'trackPrice') double? trackPrice,
    @JsonKey(name: 'releaseDate') DateTime? releaseDate,
    @JsonKey(name: 'collectionExplicitness') String? collectionExplicitness,
    @JsonKey(name: 'trackExplicitness') String? trackExplicitness,
    @JsonKey(name: 'discCount') int? discCount,
    @JsonKey(name: 'discNumber') int? discNumber,
    @JsonKey(name: 'trackCount') int? trackCount,
    @JsonKey(name: 'trackNumber') int? trackNumber,
    @JsonKey(name: 'trackTimeMillis') int? trackTimeMillis,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'currency') String? currency,
    @JsonKey(name: 'primaryGenreName') String? primaryGenreName,
    @JsonKey(name: 'isStreamable') bool? isStreamable,
  }) = _Music;

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);

  // this allow creation of getter.
  const Music._();
}
