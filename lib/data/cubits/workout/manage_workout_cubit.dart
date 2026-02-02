import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/workout_repository.dart';

abstract class ManageWorkoutState {}

class ManageWorkoutsInit extends ManageWorkoutState {}

class AddWorkoutInProgress extends ManageWorkoutState {}

class AddWorkoutSuccess extends ManageWorkoutState {
  Workout workout;

  AddWorkoutSuccess(this.workout);
}

class AddWorkoutFail extends ManageWorkoutState {
  String message;

  AddWorkoutFail(this.message);
}

class UpdateWorkoutInProgress extends ManageWorkoutState {}

class UpdateWorkoutSuccess extends ManageWorkoutState {
  Workout workout;

  UpdateWorkoutSuccess(this.workout);
}

class UpdateWorkoutFail extends ManageWorkoutState {
  String message;

  UpdateWorkoutFail(this.message);
}

class DeleteWorkoutInProgress extends ManageWorkoutState {}

class DeleteWorkoutSuccess extends ManageWorkoutState {
  int id;

  DeleteWorkoutSuccess(this.id);
}

class DeleteWorkoutFail extends ManageWorkoutState {
  String message;

  DeleteWorkoutFail(this.message);
}

class ManageWorkoutCubit extends Cubit<ManageWorkoutState> {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  ManageWorkoutCubit() : super(ManageWorkoutsInit());

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
      final addedWorkout = await _workoutRepository.addWorkout(workout);
      emit(AddWorkoutSuccess(addedWorkout));
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
      final updatedWorkout = await _workoutRepository.updateWorkout(workout);
      emit(UpdateWorkoutSuccess(updatedWorkout));
    } on TypeError catch (e, st) {
      emit(UpdateWorkoutFail(e.toString()));
    } catch (e) {
      emit(UpdateWorkoutFail(e.toString()));
    }
  }

  Future<void> deleteWorkout({required int id}) async {
    emit(DeleteWorkoutInProgress());
    try {
      final result = await _workoutRepository.delete(id);
      emit(DeleteWorkoutSuccess(id));
    } on TypeError catch (e, st) {
      emit(DeleteWorkoutFail(e.toString()));
    } catch (e) {
      emit(DeleteWorkoutFail(e.toString()));
    }
  }
}
