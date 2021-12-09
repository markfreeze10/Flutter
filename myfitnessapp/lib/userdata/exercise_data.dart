import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class ExerciseData {
  final String name;
  final String description;
  final BodyCategory category;
  final String imageName;

  ExerciseData(
      {required this.name,
      required this.description,
      required this.category,
      required this.imageName});
}
