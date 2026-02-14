import 'package:flutter_bloc/flutter_bloc.dart';
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

  void changeExercise(int exerciseId) {}
}

enum RecordWorkoutEvent {
  reset,
  addSet,
  removeLastSet,
}
