import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/data/models/workout_set.dart';

abstract class RecordWorkoutState {}

class RecordWorkoutInit extends RecordWorkoutState {}

class RecordWorkoutCompleted extends RecordWorkoutState {
  Workout workout;

  RecordWorkoutCompleted(this.workout);
}

class RecordWorkoutInProgress extends RecordWorkoutState {
  int routineId;
  int currentExerciseId;
  Map<int, List<WorkoutSet>> setsData;
  RecordWorkoutEvent event;

  RecordWorkoutInProgress({
    required this.routineId,
    required this.currentExerciseId,
    required this.setsData,
    required this.event,
  });

  RecordWorkoutInProgress copyWith({
    int? currentExerciseId,
    Map<int, List<WorkoutSet>>? setsData,
    RecordWorkoutEvent? event,
  }) => RecordWorkoutInProgress(
    routineId: routineId,
    currentExerciseId: currentExerciseId ?? this.currentExerciseId,
    setsData: setsData ?? this.setsData,
    event: event ?? this.event,
  );
}

class RecordWorkoutCubit extends Cubit<RecordWorkoutState> {
  RecordWorkoutCubit() : super(RecordWorkoutInit());

  void startWorkout(int routineId, int exerciseId) {
    emit(
      RecordWorkoutInProgress(
        routineId: routineId,
        currentExerciseId: exerciseId,
        setsData: {exerciseId: []},
        event: RecordWorkoutEvent.reset,
      ),
    );
  }

  void changeExercise(int exerciseId) {
    if (state is RecordWorkoutInProgress) {
      final data = state as RecordWorkoutInProgress;
      if (!data.setsData.containsKey(exerciseId)) {
        data.setsData[exerciseId] = [];
      }
      emit(
        data.copyWith(
          currentExerciseId: exerciseId,
          setsData: data.setsData,
          event: RecordWorkoutEvent.reset,
        ),
      );
    }
  }

  void addSet(WorkoutSet set) {
    if (state is RecordWorkoutInProgress) {
      final data = (state as RecordWorkoutInProgress);
      final setsData = data.setsData;

      setsData[data.currentExerciseId]!.add(set);
      emit(data.copyWith(setsData: setsData, event: RecordWorkoutEvent.addSet));
    }
  }

  void removeLastSet() {
    if (state is RecordWorkoutInProgress) {
      final data = (state as RecordWorkoutInProgress);
      final setsData = data.setsData;

      setsData[data.currentExerciseId]?.removeLast();
      emit(data.copyWith(setsData: setsData, event: RecordWorkoutEvent.removeLastSet));
    }
  }

  bool hasNonEmptySets() {
    if (state is RecordWorkoutInProgress) {
      final data = state as RecordWorkoutInProgress;
      return data.setsData.values.any(((e) => e.isNotEmpty));
    }
    return false;
  }

  bool hasEmptySets() {
    if (state is RecordWorkoutInProgress) {
      final data = state as RecordWorkoutInProgress;
      return data.setsData.values.any(((e) => e.isEmpty));
    }
    return false;
  }

  void completeWorkout(String? note) {
    final data = state as RecordWorkoutInProgress;
    List<WorkoutChild> logs = [];
    for (final set in data.setsData.entries) {
      if (set.value.isEmpty) continue;
      logs.add(
        WorkoutChild(
          exerciseId: set.key,
          sets: set.value,
          exerciseName: '',
        ),
      );
    }
    final workout = Workout(
      routineId: data.routineId,
      id: -1,
      logs: logs,
      note: note,
      createdAt: DateTime.now(),
    );
    emit(RecordWorkoutCompleted(workout));
  }
}

enum RecordWorkoutEvent { reset, addSet, removeLastSet, complete }
