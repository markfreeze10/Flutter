import 'package:json_annotation/json_annotation.dart';

part 'workoutset_model.g.dart';

@JsonSerializable()
class WorkoutSet {
  final int reps;
  final double? kg;

  WorkoutSet({required this.reps, this.kg});

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);

  @override
  String toString() => 'WorkoutSet{reps: $reps, kg: $kg}';
}
