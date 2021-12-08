import 'package:flutter/foundation.dart';
import 'package:myfitnessapp/userdata/exercise_data.dart';

final Exercises = [
  ExerciseData(
      name: 'Bankdrücken mit Langhantel',
      description: 'Ellenbogen 45°',
      category: BodyCategory.chest,
      imageName: 'assets/bench_press.jpg'),
  ExerciseData(
      name: 'Klimmzüge',
      description: 'Kinn über Stange',
      category: BodyCategory.back,
      imageName: 'assets/chin_ups.jpg'),
  ExerciseData(
      name: 'Bankdrücken mit Kurzhantel',
      description: 'Ellenbogen 45°',
      category: BodyCategory.chest,
      imageName: 'assets/chest_press.jpg'),
  ExerciseData(
      name: 'Rudern',
      description: 'Ellenbogen zum Körper',
      category: BodyCategory.back,
      imageName: 'assets/rowing_machine.jpg'),
  ExerciseData(
      name: 'Bizepscurls',
      description: 'Arm ausgestreckt',
      category: BodyCategory.arms,
      imageName: 'assets/biceps_curl.jpg'),
  ExerciseData(
      name: 'Kniebeuge',
      description: 'So tief in die Hocke wie möglich',
      category: BodyCategory.legs,
      imageName: 'assets/squat.jpg'),
  ExerciseData(
      name: 'Crunches',
      description: 'Hals grade',
      category: BodyCategory.abs,
      imageName: 'assets/crunch.jpg'),
  ExerciseData(
      name: 'Schulterdrücken',
      description: 'Bauch anspannen',
      category: BodyCategory.shoulders,
      imageName: 'assets/shoulder_press.jpg'),
  ExerciseData(
      name: 'Spagat',
      description: 'Beine spreizen',
      category: BodyCategory.mobility,
      imageName: 'assets/spagat.jpg'),
];
