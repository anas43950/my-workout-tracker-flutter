import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/workout.dart';

class WorkoutRepository {
  Future<Map<String, dynamic>> addWorkout(Workout workout) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.addWorkout,
      parameter: workout.toJson(),
    );
    return response['data'];
  }

  Future<Map<String, dynamic>> updateWorkout(Workout workout) async {
    final response = await ApiService.post(
      endpoint: ApiEndpoints.updateWorkout,
      parameter: workout.toJson(includeId: true),
    );
    return response['data'];
  }

  Future<void> delete(int id) async {
    final response = await ApiService.delete(
      endpoint: "${ApiEndpoints.deleteWorkout}/$id",
    );
    return response['data'];
  }

  Future<List<dynamic>> fetchWorkouts() async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getWorkouts,
    );
    return response['data'];
  }
}
