import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_test.freezed.dart';
part 'model_test.g.dart';

@freezed
class ModelTest with _$ModelTest {
  factory ModelTest({
    required String id,
    String? name,
  }) = _ModelTest;

  factory ModelTest.fromJson(Map<String, dynamic> json) => _$ModelTestFromJson(json);
}
