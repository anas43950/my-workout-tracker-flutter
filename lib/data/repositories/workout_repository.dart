import 'dart:async';

import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/workout.dart';

class WorkoutRepository {
  final _controller = StreamController<List<Workout>>();
  List<Workout> _cache = [];
  static WorkoutRepository? _instance;

  WorkoutRepository._();

  factory WorkoutRepository() {
    _instance = _instance ?? WorkoutRepository._();
    return _instance!;
  }

  Stream<List<Workout>> get workoutsStream => _controller.stream;

  Future<void> fetchWorkouts() async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getWorkouts,
    );
    _cache = response['data'].map<Workout>((e) => Workout.fromJson(e)).toList();
    _controller.add(_cache);
  }

  Future<Workout> addWorkout(Workout workout) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.addWorkout,
      parameter: workout.toJson(),
    );
    final addedWorkout = Workout.fromJson(response['data']);
    _cache.add(addedWorkout);
    _controller.add(_cache);
    return addedWorkout;
  }

  Future<Workout> updateWorkout(Workout workout) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.updateWorkout,
      parameter: workout.toJson(includeId: true),
    );

    final updatedWorkout = Workout.fromJson(response['data']);
    _cache[_cache.indexWhere((element) => element.id == workout.id)] = updatedWorkout;
    _controller.add(_cache);

    return updatedWorkout;
  }

  Future<void> delete(int id) async {
    final response = await ApiService.delete(
      endpoint: "${ApiEndpoints.deleteWorkout}/$id",
    );
    _cache.removeWhere((element) => element.id == id);
    _controller.add(_cache);
  }
}
