import 'package:json_annotation/json_annotation.dart';
import 'package:myfitnessapp/model/exercise_model.dart';
import 'package:myfitnessapp/model/workoutset_model.dart';

part 'workoutinfo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutInfo {
  final String workoutName;
  String? workoutDescription;
  List<ExerciseData> exerciseList;
  int? likes;
  List<BodyCategory>? categoryList;
  Level? level;

  WorkoutInfo(
      {required this.workoutName,
      this.workoutDescription,
      required this.exerciseList,
      this.likes,
      this.categoryList,
      this.level});

  factory WorkoutInfo.fromJson(Map<String, dynamic> json) =>
      _$WorkoutInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutInfoToJson(this);
}

enum Level {
  @JsonValue("rookie")
  rookie,
  @JsonValue("mid")
  mid,
  @JsonValue("pro")
  pro
}
