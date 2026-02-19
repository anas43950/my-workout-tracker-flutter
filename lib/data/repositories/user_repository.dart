import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/data/models/user.dart';

class UserRepository {
  Future<User> fetchCurrentUser() async {
    final response = await ApiService.get(
      endpoint: ApiEndpoints.getCurrentUser,
    );
    return User.fromJson(response);
  }
}
