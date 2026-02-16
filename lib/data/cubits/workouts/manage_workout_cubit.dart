import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/workouts_repository.dart';

abstract class ManageWorkoutState {}

class ManageWorkoutInit extends ManageWorkoutState {}

class SaveWorkoutInProgress extends ManageWorkoutState {}

class SaveWorkoutSuccess extends ManageWorkoutState {
  Workout workout;

  SaveWorkoutSuccess({required this.workout});
}

class SaveWorkoutFail extends ManageWorkoutState {
  String message;

  SaveWorkoutFail({required this.message});
}

class FetchSingleWorkoutInProgress extends ManageWorkoutState {}

class FetchSingleWorkoutSuccess extends ManageWorkoutState {
  Workout? workout;
  DateTime? selectedDate;

  FetchSingleWorkoutSuccess({this.workout, this.selectedDate});
}

class FetchSingleWorkoutFail extends ManageWorkoutState {
  String message;

  FetchSingleWorkoutFail({required this.message});
}

class ManageWorkoutCubit extends Cubit<ManageWorkoutState> {
  ManageWorkoutCubit() : super(ManageWorkoutInit());

  Future<void> saveWorkout(Workout workout) async {
    emit(SaveWorkoutInProgress());
    try {
      final result = await WorkoutsRepository().addWorkout(workout);
      emit(SaveWorkoutSuccess(workout: result));
    } on TypeError catch (e, st) {
      emit(SaveWorkoutFail(message: e.toString()));
      debugPrint(e.toString() + st.toString());
    } catch (e) {
      emit(SaveWorkoutFail(message: e.toString()));
    }
  }

  Future<void> fetchWorkoutForRoutine(int routineId) async {
    emit(FetchSingleWorkoutInProgress());
    try {
      final result = await WorkoutsRepository().fetchWorkoutsForRoutine(routineId);
      emit(FetchSingleWorkoutSuccess(workout: result.lastOrNull, selectedDate: result.lastOrNull?.createdAt));
    } on TypeError catch (e, st) {
      emit(FetchSingleWorkoutFail(message: e.toString()));
      debugPrint(e.toString() + st.toString());
    } catch (e) {
      emit(FetchSingleWorkoutFail(message: e.toString()));
    }
  }

  Future<void> fetchWorkoutForDate(DateTime date) async {
    emit(FetchSingleWorkoutInProgress());
    try {
      final result = await WorkoutsRepository().fetchWorkoutsForDate(date);
      emit(FetchSingleWorkoutSuccess(workout: result.lastOrNull, selectedDate: date));
    } catch (e) {
      emit(FetchSingleWorkoutFail(message: e.toString()));
    }
  }
}
