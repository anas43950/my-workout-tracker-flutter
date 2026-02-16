import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/repositories/exercises_repository.dart';

abstract class ExercisesListState {}

class FetchExercisesInit extends ExercisesListState {}

class FetchExercisesInProgress extends ExercisesListState {}

class ExercisesListRefreshed extends ExercisesListState {
  List<Exercise> exercises;

  // We need a tag to keep track of exercises searched on different screens
  Map<String, Iterable<Exercise>>? searchedExercises;

  ExercisesListRefreshed(this.exercises, {this.searchedExercises});

  ExercisesListRefreshed copyWith({
    List<Exercise>? exercises,
    Map<String, Iterable<Exercise>>? searchedExercises,
  }) => ExercisesListRefreshed(
    exercises ?? this.exercises,
    searchedExercises: searchedExercises ?? this.searchedExercises,
  );
}

class FetchExercisesFail extends ExercisesListState {
  String message;

  FetchExercisesFail(this.message);
}

class ExercisesListCubit extends Cubit<ExercisesListState> {
  late final ExercisesRepository _repository;
  late final StreamSubscription _subscription;

  ExercisesListCubit() : super(FetchExercisesInit()) {
    _repository = ExercisesRepository();
    _subscription = _repository.exercisesStream.listen((exercises) {
      emit(ExercisesListRefreshed(exercises));
    });
  }

  Future<void> fetchExercises() async {
    emit(FetchExercisesInProgress());
    try {
      await _repository.fetchExercises();

      // Not emitting success state since that will be handled by stream listener
    } catch (e) {
      emit(FetchExercisesFail(e.toString()));
    }
  }

  void searchExercises(String searchText, String tag) {
    if (state is ExercisesListRefreshed) {
      final data = state as ExercisesListRefreshed;

      final searchedExercises = data.searchedExercises ?? {};

      if (searchText.isEmpty) {
        searchedExercises.remove(tag);
      } else {
        searchedExercises[tag] = data.exercises.where((e) => e.name.toLowerCase().contains(searchText.toLowerCase()));
      }
      emit(data.copyWith(searchedExercises: searchedExercises));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
