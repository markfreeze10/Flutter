import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_data.g.dart';

@JsonSerializable()
class ExerciseData {
  final String name;
  final String description;
  final BodyCategory category;
  final String imageName;
  final bool editable;

  ExerciseData(
      {required this.name,
      required this.description,
      required this.category,
      required this.imageName,
      required this.editable});

  factory ExerciseData.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDataToJson(this);

  @override
  String toString() =>
      'ExerciseData{name: $name, description: $description, category: $category, imageName: $imageName, editable: $editable}';
}

enum BodyCategory { chest, back, arms, abs, legs, shoulders, mobility, all }

String getCategoryName(BodyCategory category) {
  switch (category) {
    case BodyCategory.chest:
      return 'Brust';
      break;
    case BodyCategory.back:
      return 'Rücken';
      break;
    case BodyCategory.arms:
      return 'Arme';
      break;
    case BodyCategory.abs:
      return 'Bauch';
      break;
    case BodyCategory.legs:
      return 'Beine';
      break;
    case BodyCategory.shoulders:
      return 'Schultern';
      break;
    case BodyCategory.mobility:
      return 'Mobility';
      break;
    case BodyCategory.all:
      return 'Alle Übungen';
      break;
    default:
      return 'Fehler';
      break;
  }
}
