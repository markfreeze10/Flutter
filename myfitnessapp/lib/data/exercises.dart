import 'package:flutter/foundation.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

final Exercises = [
  ExerciseData(
      name: 'Bankdrücken mit Langhantel',
      description: 'Ellenbogen 45°',
      category: BodyCategory.chest),
  ExerciseData(
      name: 'Klimmzüge',
      description: 'Kinn über Stange',
      category: BodyCategory.back),
  ExerciseData(
      name: 'Bizepscurls',
      description: 'Arm ausgestreckt',
      category: BodyCategory.arms),
  ExerciseData(
      name: 'Kniebeuge',
      description: 'So tief in die Hocke wie möglich',
      category: BodyCategory.legs),
  ExerciseData(
      name: 'Crunches', description: 'Hals grade', category: BodyCategory.abs),
  ExerciseData(
      name: 'Schulterdrücken',
      description: 'Bauch anspannen',
      category: BodyCategory.shoulders),
  ExerciseData(
      name: 'Spagat',
      description: 'Beine spreizen',
      category: BodyCategory.mobility)
];
