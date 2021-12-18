// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workoutset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) => WorkoutSet(
      reps: json['reps'] as int,
      kg: (json['kg'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'kg': instance.kg,
    };
