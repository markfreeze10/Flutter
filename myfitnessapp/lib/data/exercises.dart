import 'package:flutter/foundation.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

final Exercises = [
  ExerciseData(
      name: 'Bankdrücken mit Langhantel',
      description: 'Ellenbogen 45°',
      category: BodyCategory.chest,
      imageName: 'assets/bench_press.jpg',
      editable: false),
  ExerciseData(
      name: 'Klimmzüge',
      description: 'Kinn über Stange',
      category: BodyCategory.back,
      imageName: 'assets/chin_ups.jpg',
      editable: false),
  ExerciseData(
      name: 'Bankdrücken mit Kurzhantel',
      description: 'Ellenbogen 45°',
      category: BodyCategory.chest,
      imageName: 'assets/chest_press.jpg',
      editable: false),
  ExerciseData(
      name: 'Rudern',
      description: 'Ellenbogen zum Körper',
      category: BodyCategory.back,
      imageName: 'assets/rowing_machine.jpg',
      editable: false),
  ExerciseData(
      name: 'Bizepscurls',
      description: 'Arm ausgestreckt',
      category: BodyCategory.arms,
      imageName: 'assets/biceps_curl.jpg',
      editable: false),
  ExerciseData(
      name: 'Kniebeuge',
      description: 'So tief in die Hocke wie möglich',
      category: BodyCategory.legs,
      imageName: 'assets/squat.jpg',
      editable: false),
  ExerciseData(
      name: 'Crunches',
      description: 'Hals grade',
      category: BodyCategory.abs,
      imageName: 'assets/crunch.jpg',
      editable: false),
  ExerciseData(
      name: 'Schulterdrücken',
      description: 'Bauch anspannen',
      category: BodyCategory.shoulders,
      imageName: 'assets/shoulder_press.jpg',
      editable: false),
  ExerciseData(
      name: 'Spagat',
      description: 'Beine spreizen',
      category: BodyCategory.mobility,
      imageName: 'assets/spagat.jpg',
      editable: false),
];
