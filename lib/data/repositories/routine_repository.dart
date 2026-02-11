import 'dart:async';

import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/routine.dart';

class RoutineRepository {
  final _controller = StreamController<List<Routine>>();
  List<Routine> _cache = [];
  static RoutineRepository? _instance;

  RoutineRepository._();

  factory RoutineRepository() {
    _instance = _instance ?? RoutineRepository._();
    return _instance!;
  }

  Stream<List<Routine>> get routinesStream => _controller.stream;

  Future<void> fetchRoutines() async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getRoutines,
    );
    _cache = response['data'].map<Routine>((e) => Routine.fromJson(e)).toList();
    _controller.add(_cache);
  }

  Future<Routine> fetchRoutineForName(String name) async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getRoutineByName,
      queryParameters: {'name': name},
    );
    return Routine.fromJson(response['data']);
  }

  Future<Routine> addRoutine(Routine routine) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.addRoutine,
      parameter: routine.toJson(),
    );
    final addedRoutine = Routine.fromJson(response['data']);
    _cache.add(addedRoutine);
    _controller.add(_cache);
    return addedRoutine;
  }

  Future<Routine> updateRoutine(Routine routine) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.updateRoutine,
      parameter: routine.toJson(includeId: true),
    );

    final updatedRoutine = Routine.fromJson(response['data']);
    _cache[_cache.indexWhere((element) => element.id == routine.id)] = updatedRoutine;
    _controller.add(_cache);

    return updatedRoutine;
  }

  Future<void> delete(int id) async {
    final response = await ApiService.delete(
      endpoint: "${ApiEndpoints.deleteRoutine}/$id",
    );
    _cache.removeWhere((element) => element.id == id);
    _controller.add(_cache);
  }
}
