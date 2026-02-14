import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/repositories/exercises_repository.dart';

abstract class ManageExerciseState {}

class ManageExercisesInit extends ManageExerciseState {}

class AddExerciseInProgress extends ManageExerciseState {}

class AddExerciseSuccess extends ManageExerciseState {
  Exercise exercise;

  AddExerciseSuccess(this.exercise);
}

class AddExerciseFail extends ManageExerciseState {
  String message;

  AddExerciseFail(this.message);
}

class UpdateExerciseInProgress extends ManageExerciseState {}

class UpdateExerciseSuccess extends ManageExerciseState {
  Exercise exercise;

  UpdateExerciseSuccess(this.exercise);
}

class UpdateExerciseFail extends ManageExerciseState {
  String message;

  UpdateExerciseFail(this.message);
}

class DeleteExerciseInProgress extends ManageExerciseState {}

class DeleteExerciseSuccess extends ManageExerciseState {
  int id;

  DeleteExerciseSuccess(this.id);
}

class DeleteExerciseFail extends ManageExerciseState {
  String message;

  DeleteExerciseFail(this.message);
}

class ManageExerciseCubit extends Cubit<ManageExerciseState> {
  final ExercisesRepository _repository = ExercisesRepository();
  ManageExerciseCubit() : super(ManageExercisesInit());

  Future<void> addExercise({
    required String name,
    required int sets,
    required int repRangeFrom,
    required int repRangeTo,
  }) async {
    emit(AddExerciseInProgress());
    try {
      final exercise = Exercise(
        id: -1,
        name: name,
        sets: sets,
        repRangeFrom: repRangeFrom,
        repRangeTo: repRangeTo,
      );
      final addedExercise = await _repository.addExercise(exercise);
      emit(AddExerciseSuccess(addedExercise));
    } on TypeError catch (e, st) {
      emit(AddExerciseFail(e.toString()));
    } catch (e) {
      emit(AddExerciseFail(e.toString()));
    }
  }

  Future<void> updateExercise({
    required int id,
    required String name,
    required int sets,
    required int repRangeFrom,
    required int repRangeTo,
  }) async {
    emit(UpdateExerciseInProgress());
    try {
      final exercise = Exercise(
        id: id,
        name: name,
        sets: sets,
        repRangeFrom: repRangeFrom,
        repRangeTo: repRangeTo,
      );
      final updatedExercise = await _repository.updateExercise(exercise);
      emit(UpdateExerciseSuccess(updatedExercise));
    } on TypeError catch (e, st) {
      emit(UpdateExerciseFail(e.toString()));
    } catch (e) {
      emit(UpdateExerciseFail(e.toString()));
    }
  }

  Future<void> deleteExercise({required int id}) async {
    emit(DeleteExerciseInProgress());
    try {
      final result = await _repository.delete(id);
      emit(DeleteExerciseSuccess(id));
    } on TypeError catch (e, st) {
      emit(DeleteExerciseFail(e.toString()));
    } catch (e) {
      emit(DeleteExerciseFail(e.toString()));
    }
  }
}
