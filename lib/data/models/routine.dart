import 'package:workout_tracker/data/models/exercise.dart';

class Routine {
  final int id;
  final String name;
  final List<Exercise> exercises;

  Routine({required this.id, required this.name, required this.exercises});

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    id: json['id'],
    name: json['name'],
    exercises: json['exercises'].map<Exercise>((e) => Exercise.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson({bool includeId = false}) => {
    if (includeId) 'id': id,
    'name': name,
    'exercises_ids': exercises.map((e) => e.id).toList(),
  };
}