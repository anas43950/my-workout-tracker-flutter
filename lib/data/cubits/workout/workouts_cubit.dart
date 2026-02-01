import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/workout_repository.dart';

abstract class WorkoutsState {}

class WorkoutsInit extends WorkoutsState {}

class AddWorkoutInProgress extends WorkoutsState {}

class AddWorkoutSuccess extends WorkoutsState {
  Workout workout;

  AddWorkoutSuccess(this.workout);
}

class AddWorkoutFail extends WorkoutsState {
  String message;

  AddWorkoutFail(this.message);
}

class UpdateWorkoutInProgress extends WorkoutsState {}

class UpdateWorkoutSuccess extends WorkoutsState {
  Workout workout;

  UpdateWorkoutSuccess(this.workout);
}

class UpdateWorkoutFail extends WorkoutsState {
  String message;

  UpdateWorkoutFail(this.message);
}

class FetchWorkoutsInProgress extends WorkoutsState {}

class FetchWorkoutsSuccess extends WorkoutsState {
  List<Workout> workouts;

  FetchWorkoutsSuccess(this.workouts);
}

class FetchWorkoutsFail extends WorkoutsState {
  String message;

  FetchWorkoutsFail(this.message);
}

class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit() : super(WorkoutsInit());

  Future<void> fetchWorkouts() async {
    emit(FetchWorkoutsInProgress());
    try {
      final result = await WorkoutRepository().fetchWorkouts();
      final workouts = result.map<Workout>((e) => Workout.fromJson(e)).toList();
      emit(FetchWorkoutsSuccess(workouts));
    } catch (e) {
      emit(FetchWorkoutsFail(e.toString()));
    }
  }

  Future<void> addWorkout({
    required String name,
    required int sets,
    required int repRangeFrom,
    required int repRangeTo,
  }) async {
    emit(AddWorkoutInProgress());
    try {
      final workout = Workout(
        id: -1,
        name: name,
        sets: sets,
        repRangeFrom: repRangeFrom,
        repRangeTo: repRangeTo,
      );
      final result = await WorkoutRepository().addWorkout(workout);
      emit(AddWorkoutSuccess(Workout.fromJson(result)));
    } on TypeError catch (e, st) {
      emit(AddWorkoutFail(e.toString()));
    } catch (e) {
      emit(AddWorkoutFail(e.toString()));
    }
  }

  Future<void> updateWorkout({
    required int id,
    required String name,
    required int sets,
    required int repRangeFrom,
    required int repRangeTo,
  }) async {
    emit(UpdateWorkoutInProgress());
    try {
      final workout = Workout(
        id: id,
        name: name,
        sets: sets,
        repRangeFrom: repRangeFrom,
        repRangeTo: repRangeTo,
      );
      final result = await WorkoutRepository().updateWorkout(workout);
      emit(UpdateWorkoutSuccess(Workout.fromJson(result)));
    } on TypeError catch (e, st) {

      emit(UpdateWorkoutFail(e.toString()));
    } catch (e) {
      emit(UpdateWorkoutFail(e.toString()));
    }
  }
}
