import 'dart:async';

import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/exercise.dart';

class ExercisesRepository {
  final _controller = StreamController<List<Exercise>>();
  List<Exercise> _cache = [];
  static ExercisesRepository? _instance;

  ExercisesRepository._();

  factory ExercisesRepository() {
    _instance = _instance ?? ExercisesRepository._();
    return _instance!;
  }

  Stream<List<Exercise>> get exercisesStream => _controller.stream;

  Future<void> fetchExercises() async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getExercises,
    );
    _cache = response['data'].map<Exercise>((e) => Exercise.fromJson(e)).toList();
    _controller.add(_cache);
  }

  Future<Exercise> addExercise(Exercise exercise) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.addExercise,
      parameter: exercise.toJson(),
    );
    final addedExercise = Exercise.fromJson(response['data']);
    _cache.add(addedExercise);
    _controller.add(_cache);
    return addedExercise;
  }

  Future<Exercise> updateExercise(Exercise exercise) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.updateExercise,
      parameter: exercise.toJson(includeId: true),
    );

    final updatedExercise = Exercise.fromJson(response['data']);
    _cache[_cache.indexWhere((element) => element.id == exercise.id)] = updatedExercise;
    _controller.add(_cache);

    return updatedExercise;
  }

  Future<void> delete(int id) async {
    final response = await ApiService.delete(
      endpoint: "${ApiEndpoints.deleteExercise}/$id",
    );
    _cache.removeWhere((element) => element.id == id);
    _controller.add(_cache);
  }
}
