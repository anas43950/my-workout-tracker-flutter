import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repositories/workouts_repository.dart';

abstract class WorkoutsListState {}

class FetchWorkoutsInit extends WorkoutsListState {}

class FetchWorkoutsInProgress extends WorkoutsListState {}

class FetchWorkoutsSuccess extends WorkoutsListState {
  List<Workout> workouts;

  FetchWorkoutsSuccess(this.workouts);
}

class FetchWorkoutsFail extends WorkoutsListState {
  String message;

  FetchWorkoutsFail(this.message);
}

class WorkoutsListCubit extends Cubit<WorkoutsListState> {
  late final WorkoutsRepository _repository;
  late final StreamSubscription _subscription;

  WorkoutsListCubit() : super(FetchWorkoutsInit()) {
    _repository = WorkoutsRepository();
    _subscription = _repository.routinesStream.listen((workouts) {
      emit(FetchWorkoutsSuccess(workouts));
    });
  }

  Future<void> fetchWorkouts() async {
    emit(FetchWorkoutsInProgress());
    try {
      await _repository.fetchWorkouts();
      // Not emitting success state since that will be handled by stream listener
    } catch (e) {
      emit(FetchWorkoutsFail(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
