// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workoutinfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutInfo _$WorkoutInfoFromJson(Map<String, dynamic> json) => WorkoutInfo(
      workoutName: json['workoutName'] as String,
      workoutDescription: json['workoutDescription'] as String?,
      exerciseList: (json['exerciseList'] as List<dynamic>)
          .map((e) => ExerciseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as int?,
      categoryList: (json['categoryList'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$BodyCategoryEnumMap, e))
          .toList(),
      level: $enumDecodeNullable(_$LevelEnumMap, json['level']),
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$WorkoutInfoToJson(WorkoutInfo instance) =>
    <String, dynamic>{
      'name': instance.workoutName,
      'description': instance.workoutDescription,
      'exerciseList': instance.exerciseList.map((e) => e.toJson()).toList(),
      'likes': instance.likes,
      'categoryList':
          instance.categoryList?.map((e) => _$BodyCategoryEnumMap[e]).toList(),
      'level': _$LevelEnumMap[instance.level],
      'liked': instance.liked,
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

const _$LevelEnumMap = {
  Level.rookie: 'rookie',
  Level.mid: 'mid',
  Level.pro: 'pro',
};
