import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/user.dart';
import 'package:workout_tracker/data/repositories/auth_repository.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;
  final String token;

  RegisterSuccess(this.user, this.token);
}

class RegisterFail extends RegisterState {
  final String message;

  RegisterFail(this.message);
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterInProgress());
    try {
      final result = await AuthRepository().register(
        name: name,
        email: email,
        password: password,
      );
      emit(RegisterSuccess(User.fromJson(result['data']), result['token']));
    } catch (e) {
      emit(RegisterFail(e.toString()));
    }
  }
}
