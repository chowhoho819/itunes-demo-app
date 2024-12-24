import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:itune_test_app/model/unit_test/model_test.dart';
import 'package:itune_test_app/utils/serializer.dart';

void main() {
  group('FreezedSerializer', () {
    test('[From Json Success Case]', () {
      // Arrange
      final jsonString = '{"id": "1", "name": "John Doe"}';
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Act
      final testModel = FreezedSerializer.fromJson<ModelTest>(
        jsonData,
        ModelTest.fromJson,
      );

      // Assert
      expect(testModel.id, '1');
      expect(testModel.name, 'John Doe');
    });

    test('[To Json Success Case]', () {
      // Arrange
      final testModel = ModelTest(id: '1', name: 'John Doe');

      // Act
      final jsonData = FreezedSerializer.toJson<ModelTest>(
        testModel,
        (model) => model.toJson(),
      );

      // Assert
      expect(jsonData['id'], '1');
      expect(jsonData['name'], 'John Doe');
    });

    test('[From Json Invalid Structure Throw]', () {
      // Arrange
      final invalidJsonString = '{"id": 1, "name": "John Doe"}'; // id should be a String
      final Map<String, dynamic> invalidJsonData = json.decode(invalidJsonString);

      // Act & Assert
      expect(
          () => FreezedSerializer.fromJson<ModelTest>(
                invalidJsonData,
                ModelTest.fromJson,
              ),
          throwsA(isA<TypeError>()));
    });

    test('[To Json Null Value Test]', () {
      // Arrange
      final userModel = ModelTest(id: '1', name: null); // Assuming name is nullable

      // Act
      final jsonData = FreezedSerializer.toJson<ModelTest>(
        userModel,
        (model) => model.toJson(),
      );

      // Assert
      expect(jsonData['id'], '1');
      expect(jsonData['name'], null);
    });
  });
}
