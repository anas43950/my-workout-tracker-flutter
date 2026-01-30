import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/login_cubit.dart';
import 'package:workout_tracker/data/cubits/auth/register_cubit.dart';

class RegisterCubits {
  List<BlocProvider> providers = [
    BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
  ];
}
