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
      return 'Alle Kategorien';
      break;
    default:
      return 'Fehler';
      break;
  }
}

class ExerciseData {
  String? name;
  String? description;
  BodyCategory? category;

  ExerciseData({this.name, this.description, this.category});
}
