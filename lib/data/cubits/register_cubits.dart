import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/login_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/register_cubit.dart';
import 'package:workout_tracker/data/cubits/workout/manage_workout_cubit.dart';
import 'package:workout_tracker/data/cubits/workout/workouts_list_cubit.dart';

class RegisterCubits {
  List<BlocProvider> get providers => [
    BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
    BlocProvider<ManageWorkoutCubit>(create: (context) => ManageWorkoutCubit()),
    BlocProvider<WorkoutsListCubit>(create: (context) => WorkoutsListCubit()),
  ];
}
