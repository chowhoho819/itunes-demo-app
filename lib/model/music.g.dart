// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MusicImpl _$$MusicImplFromJson(Map<String, dynamic> json) => _$MusicImpl(
      previewUrl: json['previewUrl'] as String?,
      artworkUrl30: json['artworkUrl30'] as String?,
      artworkUrl60: json['artworkUrl60'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      collectionPrice: (json['collectionPrice'] as num?)?.toDouble(),
      trackPrice: (json['trackPrice'] as num?)?.toDouble(),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      collectionExplicitness: json['collectionExplicitness'] as String?,
      trackExplicitness: json['trackExplicitness'] as String?,
      discCount: (json['discCount'] as num?)?.toInt(),
      discNumber: (json['discNumber'] as num?)?.toInt(),
      trackCount: (json['trackCount'] as num?)?.toInt(),
      trackNumber: (json['trackNumber'] as num?)?.toInt(),
      trackTimeMillis: (json['trackTimeMillis'] as num?)?.toInt(),
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      primaryGenreName: json['primaryGenreName'] as String?,
      isStreamable: json['isStreamable'] as bool?,
    );

Map<String, dynamic> _$$MusicImplToJson(_$MusicImpl instance) =>
    <String, dynamic>{
      'previewUrl': instance.previewUrl,
      'artworkUrl30': instance.artworkUrl30,
      'artworkUrl60': instance.artworkUrl60,
      'artworkUrl100': instance.artworkUrl100,
      'collectionPrice': instance.collectionPrice,
      'trackPrice': instance.trackPrice,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'collectionExplicitness': instance.collectionExplicitness,
      'trackExplicitness': instance.trackExplicitness,
      'discCount': instance.discCount,
      'discNumber': instance.discNumber,
      'trackCount': instance.trackCount,
      'trackNumber': instance.trackNumber,
      'trackTimeMillis': instance.trackTimeMillis,
      'country': instance.country,
      'currency': instance.currency,
      'primaryGenreName': instance.primaryGenreName,
      'isStreamable': instance.isStreamable,
    };
