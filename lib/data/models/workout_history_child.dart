import 'package:workout_tracker/data/models/workout_history_set.dart';

class WorkoutHistoryChild {
  final int workoutId;
  final String workoutName;
  final List<WorkoutHistorySet> sets;

  WorkoutHistoryChild({
    required this.workoutId,
    required this.workoutName,
    required this.sets,
  });

  factory WorkoutHistoryChild.fromJson(Map<String, dynamic> json) => WorkoutHistoryChild(
    workoutId: json['workout_id'],
    workoutName: json['workout_name'],
    sets: json['sets'].map((x) => WorkoutHistorySet.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'workout_id': workoutId,
    'sets': sets.map((e) => e.toJson()),
  };
}
