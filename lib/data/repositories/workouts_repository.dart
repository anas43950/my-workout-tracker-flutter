import 'dart:async';

import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/workout.dart';

class WorkoutsRepository {
  final _controller = StreamController<List<Workout>>();
  List<Workout> _cache = [];
  static WorkoutsRepository? _instance;

  WorkoutsRepository._();

  factory WorkoutsRepository() {
    _instance = _instance ?? WorkoutsRepository._();
    return _instance!;
  }

  Stream<List<Workout>> get routinesStream => _controller.stream;

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

  Future<List<Workout>> fetchWorkoutsForRoutine(int routineId) async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getWorkoutsForRoutine,
      queryParameters: {'routine_id': routineId},
    );
    return response['data'].map<Workout>((e) => Workout.fromJson(e)).toList();
  }

  Future<List<Workout>> fetchWorkoutsForDate(DateTime date) async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getWorkoutsForDate,
      queryParameters: {'date': date},
    );
    return response['data'].map<Workout>((e) => Workout.fromJson(e)).toList();
  }
  //
  // Future<Workout> updateWorkout(Workout routine) async {
  //   final response = await ApiService.post(
  //     endpoint: ApiEndpoints.updateWorkout,
  //     parameter: routine.toJson(includeId: true),
  //   );
  //
  //   final updatedWorkout = Workout.fromJson(response['data']);
  //   _cache[_cache.indexWhere((element) => element.id == routine.id)] = updatedWorkout;
  //   _controller.add(_cache);
  //
  //   return updatedWorkout;
  // }
  //
  // Future<void> delete(int id) async {
  //   final response = await ApiService.delete(
  //     endpoint: "${ApiEndpoints.deleteWorkout}/$id",
  //   );
  //   _cache.removeWhere((element) => element.id == id);
  //   _controller.add(_cache);
  // }
}