import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._();

  // ngrok http 8000

  static final baseUrl = kDebugMode
      ? 'https://a8f3-2401-4900-88d4-c9d2-e8fd-ac1f-fb99-600f.ngrok-free.app/api/'
      : 'https://anas-workout-tracker.fly.dev/api/';

  // static final baseUrl = kDebugMode ? 'http://10.0.2.2:8000/api/' : 'https://anas-workout-tracker.fly.dev/api/';

  static final register = 'register';
  static final login = 'login';
  static final getCurrentUser = 'user';

  static final getExercises = 'exercises/';
  static final addExercise = 'exercises/add';
  static final updateExercise = 'exercises/edit';
  static final deleteExercise = 'exercises/delete';

  static final getRoutines = 'routines/';
  static final getRoutineByName = 'routines/by-name';
  static final addRoutine = 'routines/add';
  static final updateRoutine = 'routines/edit';
  static final deleteRoutine = 'routines/delete';

  static final getWorkouts = 'workouts/';
  static final addWorkout = 'workouts/add';
  static final getWorkoutsForRoutine = 'workouts/for-routine';
  static final getWorkoutsForDate = 'workouts/for-date';
}
