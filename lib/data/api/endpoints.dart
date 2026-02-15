class ApiEndpoints {
  ApiEndpoints._();

  static final baseUrl = 'http://10.0.2.2:8000/api/';

  static final register = 'register';
  static final login = 'login';

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
