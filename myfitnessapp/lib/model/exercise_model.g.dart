// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseData _$ExerciseDataFromJson(Map<String, dynamic> json) => ExerciseData(
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$BodyCategoryEnumMap, json['category']),
      imageName: json['imageName'] as String,
      editable: json['editable'] as bool,
    );

Map<String, dynamic> _$ExerciseDataToJson(ExerciseData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': _$BodyCategoryEnumMap[instance.category],
      'imageName': instance.imageName,
      'editable': instance.editable,
    };

const _$BodyCategoryEnumMap = {
  BodyCategory.chest: 'chest',
  BodyCategory.back: 'back',
  BodyCategory.arms: 'arms',
  BodyCategory.abs: 'abs',
  BodyCategory.legs: 'legs',
  BodyCategory.shoulders: 'shoulders',
  BodyCategory.mobility: 'mobility',
  BodyCategory.all: 'all',
};
