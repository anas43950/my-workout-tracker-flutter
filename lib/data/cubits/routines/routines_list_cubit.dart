import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/repositories/routine_repository.dart';

abstract class RoutinesListState {}

class FetchRoutinesInit extends RoutinesListState {}

class FetchRoutinesInProgress extends RoutinesListState {}

class FetchRoutinesSuccess extends RoutinesListState {
  List<Routine> routines;

  FetchRoutinesSuccess(this.routines);
}

class FetchRoutinesFail extends RoutinesListState {
  String message;

  FetchRoutinesFail(this.message);
}

class RoutinesListCubit extends Cubit<RoutinesListState> {
  late final RoutineRepository _repository;
  late final StreamSubscription _subscription;

  RoutinesListCubit() : super(FetchRoutinesInit()) {
    _repository = RoutineRepository();
    _subscription = _repository.routinesStream.listen((routines) {
      emit(FetchRoutinesSuccess(routines));
    });
  }

  Future<void> fetchRoutines() async {
    emit(FetchRoutinesInProgress());
    try {
      await _repository.fetchRoutines();
      // Not emitting success state since that will be handled by stream listener
    } catch (e) {
      emit(FetchRoutinesFail(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
