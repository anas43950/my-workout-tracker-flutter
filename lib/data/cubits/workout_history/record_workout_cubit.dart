import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/data/models/workout_set.dart';

abstract class RecordWorkoutState {}

class RecordWorkoutInit extends RecordWorkoutState {}

class RecordWorkoutInProgress extends RecordWorkoutState {
  int currentExerciseId;
  List<WorkoutChild> logsRecordedSoFar;
  List<WorkoutSet> currentExerciseSetsCompleted;
  RecordWorkoutEvent event;

  RecordWorkoutInProgress({
    required this.currentExerciseId,
    required this.logsRecordedSoFar,
    required this.currentExerciseSetsCompleted,
    required this.event,
  });

  RecordWorkoutInProgress copyWith({
    int? currentExerciseId,
    List<WorkoutChild>? logsRecordedSoFar,
    List<WorkoutSet>? currentExerciseSetsCompleted,
    RecordWorkoutEvent? event,
  }) => RecordWorkoutInProgress(
    currentExerciseId: currentExerciseId ?? this.currentExerciseId,
    logsRecordedSoFar: logsRecordedSoFar ?? this.logsRecordedSoFar,
    currentExerciseSetsCompleted: currentExerciseSetsCompleted ?? this.currentExerciseSetsCompleted,
    event: event ?? this.event,
  );
}

class RecordWorkoutCubit extends Cubit<RecordWorkoutState> {
  RecordWorkoutCubit() : super(RecordWorkoutInit());

  void changeExercise(int exerciseId) {
    if (state is RecordWorkoutInit) {
      emit(
        RecordWorkoutInProgress(
          currentExerciseId: exerciseId,
          logsRecordedSoFar: [],
          currentExerciseSetsCompleted: [],
          event: RecordWorkoutEvent.reset,
        ),
      );
    }
    if (state is RecordWorkoutInProgress) {
      final data = state as RecordWorkoutInProgress;
      final newLog = WorkoutChild(
        exerciseId: data.currentExerciseId,
        sets: data.currentExerciseSetsCompleted,
        exerciseName: "",
      );

      final logsRecordedSoFar = data.logsRecordedSoFar;
      logsRecordedSoFar.add(newLog);
      emit(
        data.copyWith(
          currentExerciseSetsCompleted:
              data.logsRecordedSoFar.firstWhereOrNull((e) => e.exerciseId == exerciseId)?.sets ?? [],
          logsRecordedSoFar: logsRecordedSoFar,
        ),
      );
    }
  }

  void addSet(WorkoutSet set) {
    if (state is RecordWorkoutInProgress) {
      final newSets = (state as RecordWorkoutInProgress).currentExerciseSetsCompleted;
      newSets.add(set);
      emit(
        (state as RecordWorkoutInProgress).copyWith(
          currentExerciseSetsCompleted: newSets,
          event: RecordWorkoutEvent.addSet,
        ),
      );
    }
  }

  void removeLastSet() {
    if (state is RecordWorkoutInProgress) {
      final newSets = (state as RecordWorkoutInProgress).currentExerciseSetsCompleted;
      if (newSets.isNotEmpty) {
        newSets.removeLast();
      }
      emit(
        (state as RecordWorkoutInProgress).copyWith(
          currentExerciseSetsCompleted: newSets,
          event: RecordWorkoutEvent.removeLastSet,
        ),
      );
    }
  }

  Workout completeWorkout(String note) {
    final data = state as RecordWorkoutInProgress;
    return Workout(
      id: -1,
      logs: data.logsRecordedSoFar,
      note: note,
      createdAt: DateTime.now(),
    );
  }
}

enum RecordWorkoutEvent { reset, addSet, removeLastSet, complete }
