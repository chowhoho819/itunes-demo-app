// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itune_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItuneResponse _$ItuneResponseFromJson(Map<String, dynamic> json) {
  return _ItuneResponse.fromJson(json);
}

/// @nodoc
mixin _$ItuneResponse {
  @JsonKey(name: 'resultCount')
  int get resultCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'results')
  List<Music>? get results => throw _privateConstructorUsedError;

  /// Serializes this ItuneResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItuneResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItuneResponseCopyWith<ItuneResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItuneResponseCopyWith<$Res> {
  factory $ItuneResponseCopyWith(
          ItuneResponse value, $Res Function(ItuneResponse) then) =
      _$ItuneResponseCopyWithImpl<$Res, ItuneResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'results') List<Music>? results});
}

/// @nodoc
class _$ItuneResponseCopyWithImpl<$Res, $Val extends ItuneResponse>
    implements $ItuneResponseCopyWith<$Res> {
  _$ItuneResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItuneResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCount = null,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      resultCount: null == resultCount
          ? _value.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Music>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItuneResponseImplCopyWith<$Res>
    implements $ItuneResponseCopyWith<$Res> {
  factory _$$ItuneResponseImplCopyWith(
          _$ItuneResponseImpl value, $Res Function(_$ItuneResponseImpl) then) =
      __$$ItuneResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'results') List<Music>? results});
}

/// @nodoc
class __$$ItuneResponseImplCopyWithImpl<$Res>
    extends _$ItuneResponseCopyWithImpl<$Res, _$ItuneResponseImpl>
    implements _$$ItuneResponseImplCopyWith<$Res> {
  __$$ItuneResponseImplCopyWithImpl(
      _$ItuneResponseImpl _value, $Res Function(_$ItuneResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItuneResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCount = null,
    Object? results = freezed,
  }) {
    return _then(_$ItuneResponseImpl(
      resultCount: null == resultCount
          ? _value.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Music>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItuneResponseImpl implements _ItuneResponse {
  _$ItuneResponseImpl(
      {@JsonKey(name: 'resultCount') required this.resultCount,
      @JsonKey(name: 'results') final List<Music>? results})
      : _results = results;

  factory _$ItuneResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItuneResponseImplFromJson(json);

  @override
  @JsonKey(name: 'resultCount')
  final int resultCount;
  final List<Music>? _results;
  @override
  @JsonKey(name: 'results')
  List<Music>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ItuneResponse(resultCount: $resultCount, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItuneResponseImpl &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, resultCount, const DeepCollectionEquality().hash(_results));

  /// Create a copy of ItuneResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItuneResponseImplCopyWith<_$ItuneResponseImpl> get copyWith =>
      __$$ItuneResponseImplCopyWithImpl<_$ItuneResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItuneResponseImplToJson(
      this,
    );
  }
}

abstract class _ItuneResponse implements ItuneResponse {
  factory _ItuneResponse(
          {@JsonKey(name: 'resultCount') required final int resultCount,
          @JsonKey(name: 'results') final List<Music>? results}) =
      _$ItuneResponseImpl;

  factory _ItuneResponse.fromJson(Map<String, dynamic> json) =
      _$ItuneResponseImpl.fromJson;

  @override
  @JsonKey(name: 'resultCount')
  int get resultCount;
  @override
  @JsonKey(name: 'results')
  List<Music>? get results;

  /// Create a copy of ItuneResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItuneResponseImplCopyWith<_$ItuneResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
