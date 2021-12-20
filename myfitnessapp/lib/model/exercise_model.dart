import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@JsonSerializable(explicitToJson: true)
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

enum BodyCategory {
  @JsonValue("chest")
  chest,
  @JsonValue("back")
  back,
  @JsonValue("arms")
  arms,
  @JsonValue("abs")
  abs,
  @JsonValue("legs")
  legs,
  @JsonValue("shoulders")
  shoulders,
  @JsonValue("mobility")
  mobility,
  @JsonValue("all")
  all
}

BodyCategory getNameFromCategory(String str) {
  switch (str) {
    case 'Brust':
      return BodyCategory.chest;
      break;
    case 'Rücken':
      return BodyCategory.back;
      break;
    case 'Arme':
      return BodyCategory.arms;
      break;
    case 'Beine':
      return BodyCategory.legs;
      break;
    case 'Bauch':
      return BodyCategory.abs;
      break;
    case 'Schultern':
      return BodyCategory.shoulders;
      break;
    case 'Mobility':
      return BodyCategory.mobility;
      break;
    default:
      return BodyCategory.all;
      break;
  }
}

String getCategoryName(BodyCategory cat) {
  switch (cat) {
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
    default:
      print('bljad');
      return 'Fehler';
      break;
  }
}
