import 'package:workout_tracker/data/models/workout_history_child.dart';

class WorkoutHistory {
  final int id;
  final String? note;
  final List<WorkoutHistoryChild> logs;
  final DateTime createdAt;

  WorkoutHistory({
    required this.id,
    this.note,
    required this.logs,
    required this.createdAt,
  });

  factory WorkoutHistory.fromJson(Map<String, dynamic> json) => WorkoutHistory(
    id: json['id'],
    note: json['note'],
    logs: json['logs'].map((x) => WorkoutHistoryChild.fromJson(x)).toList(),
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'note': note,
    'logs': logs.map((e) => e.toJson()),
  };
}
