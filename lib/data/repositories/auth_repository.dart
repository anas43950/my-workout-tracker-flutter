import 'package:workout_tracker/data/api/api_service.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/utils/constants.dart';

class AuthRepository {
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await ApiService.post(
      endpoint: ApiEndpoints.register,
      parameter: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
    return {
      AppStrings.token: result[AppStrings.token],
      AppStrings.user: result['data'],
    };
  }

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final result = await ApiService.post(
      endpoint: ApiEndpoints.login,
      parameter: {
        'email': email,
        'password': password,
      },
    );
    return {
      AppStrings.token: result[AppStrings.token],
      AppStrings.user: result['data'],
    };
  }
}
