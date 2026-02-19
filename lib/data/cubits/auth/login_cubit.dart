import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/user.dart';
import 'package:workout_tracker/data/repositories/auth_repository.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  final String token;

  LoginSuccess(this.user, this.token);
}

class LoginFail extends LoginState {
  final String message;

  LoginFail(this.message);
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginInProgress());
    try {
      final result = await AuthRepository().login(email: email, password: password);

      emit(LoginSuccess(User.fromJson(result['data']), result['token']));
    } catch (e) {
      emit(LoginFail(e.toString()));
    }
  }
}
