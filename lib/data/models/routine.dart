import 'package:workout_tracker/data/models/workout.dart';

class Routine {
  final int id;
  final String name;
  final List<Workout> workouts;

  Routine({required this.id, required this.name, required this.workouts});

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    id: json['id'],
    name: json['name'],
    workouts: json['workouts'].map<Workout>((e) => Workout.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson({bool includeId = false}) => {
    if (includeId) 'id': id,
    'name': name,
    'workouts_ids': workouts.map((e) => e.id).toList(),
  };
}