// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itune_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItuneResponseImpl _$$ItuneResponseImplFromJson(Map<String, dynamic> json) =>
    _$ItuneResponseImpl(
      resultCount: (json['resultCount'] as num).toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Music.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItuneResponseImplToJson(_$ItuneResponseImpl instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'results': instance.results,
    };
