import 'package:workout_tracker/data/models/workout_child.dart';

class Workout {
  final int id;
  final String? note;
  final List<WorkoutChild> logs;
  final DateTime createdAt;

  Workout({
    required this.id,
    this.note,
    required this.logs,
    required this.createdAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json['id'],
    note: json['note'],
    logs: json['logs'].map((x) => WorkoutChild.fromJson(x)).toList(),
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'note': note,
    'logs': logs.map((e) => e.toJson()),
  };
}
