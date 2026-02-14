import 'package:workout_tracker/data/models/workout_set.dart';

class WorkoutChild {
  final int exerciseId;
  final String exerciseName;
  final List<WorkoutSet> sets;

  WorkoutChild({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
  });

  factory WorkoutChild.fromJson(Map<String, dynamic> json) => WorkoutChild(
    exerciseId: json['exercise_id'],
    exerciseName: json['exercise_name'],
    sets: json['sets'].map((x) => WorkoutSet.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'exercises': exerciseId,
    'sets': sets.map((e) => e.toJson()),
  };
}
