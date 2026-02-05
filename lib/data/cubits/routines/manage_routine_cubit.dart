import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/routine_repository.dart';

abstract class ManageRoutineState {}

class ManageRoutinesInit extends ManageRoutineState {}

class AddRoutineInProgress extends ManageRoutineState {}

class AddRoutineSuccess extends ManageRoutineState {
  Routine routine;

  AddRoutineSuccess(this.routine);
}

class AddRoutineFail extends ManageRoutineState {
  String message;

  AddRoutineFail(this.message);
}

class UpdateRoutineInProgress extends ManageRoutineState {}

class UpdateRoutineSuccess extends ManageRoutineState {
  Routine routine;

  UpdateRoutineSuccess(this.routine);
}

class UpdateRoutineFail extends ManageRoutineState {
  String message;

  UpdateRoutineFail(this.message);
}

class DeleteRoutineInProgress extends ManageRoutineState {}

class DeleteRoutineSuccess extends ManageRoutineState {
  int id;

  DeleteRoutineSuccess(this.id);
}

class DeleteRoutineFail extends ManageRoutineState {
  String message;

  DeleteRoutineFail(this.message);
}

class ManageRoutineCubit extends Cubit<ManageRoutineState> {
  final RoutineRepository _routineRepository = RoutineRepository();

  ManageRoutineCubit() : super(ManageRoutinesInit());

  Future<void> addRoutine({
    required String name,
    required List<Workout> workouts,
  }) async {
    emit(AddRoutineInProgress());
    try {
      final routine = Routine(
        id: -1,
        name: name,
        workouts: workouts,
      );
      final addedRoutine = await _routineRepository.addRoutine(routine);
      emit(AddRoutineSuccess(addedRoutine));
    } on TypeError catch (e, st) {
      emit(AddRoutineFail(e.toString()));
    } catch (e) {
      emit(AddRoutineFail(e.toString()));
    }
  }

  Future<void> updateRoutine({
    required int id,
    required String name,
    required List<Workout> workouts,
  }) async {
    emit(UpdateRoutineInProgress());
    try {
      final routine = Routine(
        id: id,
        name: name,
        workouts: workouts,
      );
      final updatedRoutine = await _routineRepository.updateRoutine(routine);
      emit(UpdateRoutineSuccess(updatedRoutine));
    } on TypeError catch (e, st) {
      emit(UpdateRoutineFail(e.toString()));
    } catch (e) {
      emit(UpdateRoutineFail(e.toString()));
    }
  }

  Future<void> deleteRoutine({required int id}) async {
    emit(DeleteRoutineInProgress());
    try {
      final result = await _routineRepository.delete(id);
      emit(DeleteRoutineSuccess(id));
    } on TypeError catch (e, st) {
      emit(DeleteRoutineFail(e.toString()));
    } catch (e) {
      emit(DeleteRoutineFail(e.toString()));
    }
  }
}
