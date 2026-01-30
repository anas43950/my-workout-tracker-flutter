import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';

abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class LoggedIn extends AuthenticationState {}

class LoggedOut extends AuthenticationState {}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthInitial());

  Future<void> logout() async {
    await SharedPrefUtils.clear();
    emit(LoggedOut());
  }
}
