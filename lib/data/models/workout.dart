import 'package:workout_tracker/data/models/workout_child.dart';

class Workout {
  final int id;
  final int routineId;
  final String? note;
  final List<WorkoutChild> logs;
  final DateTime createdAt;
  final DateTime? startedAt;

  Workout({
    required this.id,
    required this.routineId,
    this.note,
    required this.logs,
    required this.createdAt,
    required this.startedAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json['id'],
    routineId: json['routine_id'],
    note: json['note'],
    logs: json['logs'].map<WorkoutChild>((x) => WorkoutChild.fromJson(x)).toList(),
    createdAt: DateTime.parse(json['created_at']),
    startedAt: DateTime.tryParse(json['started_at'] ?? ""),
  );

  Map<String, dynamic> toJson() => {
    'note': note,
    'routine_id': routineId,
    'started_at': startedAt,
    'logs': logs.map((e) => e.toJson()).toList(),
  };
}
