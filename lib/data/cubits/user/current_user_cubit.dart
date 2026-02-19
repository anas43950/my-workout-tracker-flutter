import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/user.dart';
import 'package:workout_tracker/data/repositories/user_repository.dart';

abstract class CurrentUserState {}

class CurrentUserInit extends CurrentUserState {}

class FetchCurrentUserInProgress extends CurrentUserState {}

class FetchCurrentUserFail extends CurrentUserState {}

class CurrentUserRefreshed extends CurrentUserState {
  User user;

  CurrentUserRefreshed(this.user);
}

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final UserRepository _repo = UserRepository();

  CurrentUserCubit() : super(CurrentUserInit());

  Future<void> fetchCurrentUser() async {
    emit(FetchCurrentUserInProgress());
    try {
      final user = await _repo.fetchCurrentUser();
      emit(CurrentUserRefreshed(user));
    } catch (e) {
      emit(FetchCurrentUserFail());
    }
  }
}
