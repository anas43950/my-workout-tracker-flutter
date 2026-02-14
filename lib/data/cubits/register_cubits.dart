import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/login_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/register_cubit.dart';
import 'package:workout_tracker/data/cubits/exercises/exercises_list_cubit.dart';
import 'package:workout_tracker/data/cubits/exercises/manage_exercise_cubit.dart';
import 'package:workout_tracker/data/cubits/routines/manage_routine_cubit.dart';
import 'package:workout_tracker/data/cubits/routines/routines_list_cubit.dart';
import 'package:workout_tracker/data/cubits/workout_history/record_workout_cubit.dart';

class RegisterCubits {
  List<BlocProvider> get providers => [
    BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
    BlocProvider<ManageExerciseCubit>(create: (context) => ManageExerciseCubit()),
    BlocProvider<ExercisesListCubit>(create: (context) => ExercisesListCubit()),
    BlocProvider<ManageRoutineCubit>(create: (context) => ManageRoutineCubit()),
    BlocProvider<RoutinesListCubit>(create: (context) => RoutinesListCubit()),
    BlocProvider<RecordWorkoutCubit>(create: (context) => RecordWorkoutCubit()),
  ];
}
