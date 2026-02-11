import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/routine_repository.dart';

abstract class ManageRoutineState {}

class ManageRoutinesInit extends ManageRoutineState {}

class SaveRoutineInProgress extends ManageRoutineState {}

class SaveRoutineSuccess extends ManageRoutineState {
  Routine routine;

  SaveRoutineSuccess(this.routine);
}

class SaveRoutineFail extends ManageRoutineState {
  String message;

  SaveRoutineFail(this.message);
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

class FetchRoutineForNameInProgress extends ManageRoutineState {}

class FetchRoutineForNameSuccess extends ManageRoutineState {
  Routine? routine;

  FetchRoutineForNameSuccess(this.routine);
}

class FetchRoutineForNameFail extends ManageRoutineState {
  String message;

  FetchRoutineForNameFail(this.message);
}

class ManageRoutineCubit extends Cubit<ManageRoutineState> {
  final RoutineRepository _routineRepository = RoutineRepository();

  ManageRoutineCubit() : super(ManageRoutinesInit());

  Future<void> addRoutine({
    required String name,
    required List<Workout> workouts,
  }) async {
    emit(SaveRoutineInProgress());
    try {
      final routine = Routine(
        id: -1,
        name: name,
        workouts: workouts,
      );
      final addedRoutine = await _routineRepository.addRoutine(routine);
      emit(SaveRoutineSuccess(addedRoutine));
    } on TypeError catch (e, st) {
      emit(SaveRoutineFail(e.toString()));
    } catch (e) {
      emit(SaveRoutineFail(e.toString()));
    }
  }

  Future<void> updateRoutine({
    required int id,
    required String name,
    required List<Workout> workouts,
  }) async {
    emit(SaveRoutineInProgress());
    try {
      final routine = Routine(
        id: id,
        name: name,
        workouts: workouts,
      );
      final updatedRoutine = await _routineRepository.updateRoutine(routine);
      emit(SaveRoutineSuccess(updatedRoutine));
    } on TypeError catch (e, st) {
      emit(SaveRoutineFail(e.toString()));
    } catch (e) {
      emit(SaveRoutineFail(e.toString()));
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

  Future<void> fetchRoutineForName({required String name}) async {
    emit(FetchRoutineForNameInProgress());
    try {
      final routine = await _routineRepository.fetchRoutineForName(name);
      emit(FetchRoutineForNameSuccess(routine));
    } on TypeError catch (e, st) {
      emit(FetchRoutineForNameFail(e.toString()));
    } catch (e) {
      emit(FetchRoutineForNameFail(e.toString()));
    }
  }
}
