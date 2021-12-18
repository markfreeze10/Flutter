import 'package:myfitnessapp/model/exercise_model.dart';
import 'package:myfitnessapp/model/workoutinfo_model.dart';
import 'package:myfitnessapp/model/workoutset_model.dart';

class Workout {
  final WorkoutInfo? workoutInfo;
  final ExerciseData exerciseData;
  List<WorkoutSet> workoutSet;
  String? notes;
  DateTime dateTime;

  Workout(
      {this.workoutInfo,
      required this.exerciseData,
      required this.workoutSet,
      this.notes,
      required this.dateTime});
}
