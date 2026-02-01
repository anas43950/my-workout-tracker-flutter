class ApiEndpoints {
  ApiEndpoints._();

  static final baseUrl = 'http://10.0.2.2:8000/api/';

  static final register = 'register';
  static final login = 'login';
  static final addWorkout = 'workouts/add';
  static final updateWorkout = 'workouts/edit';
  static final deleteWorkout = 'workouts/delete';
  static final getWorkouts = 'workouts/';
}
