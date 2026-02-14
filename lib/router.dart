import 'package:go_router/go_router.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/ui/screens/add_routine/rearrange_routine_exercises_screen.dart';
import 'package:workout_tracker/ui/screens/add_routine/select_routine_exercises_screen.dart';
import 'package:workout_tracker/ui/screens/auth/login_screen.dart';
import 'package:workout_tracker/ui/screens/auth/sign_up_screen.dart';
import 'package:workout_tracker/ui/screens/main/home_base_screen.dart';
import 'package:workout_tracker/ui/screens/record_workout_screen.dart';
import 'package:workout_tracker/ui/screens/splash_screen.dart';
import 'package:workout_tracker/ui/screens/view_routine.dart';
import 'package:workout_tracker/utils/constants.dart';

class Routes {
  Routes._();

  static const homeBase = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const selectRoutineExercises = '/select-routine-exercises';
  static const rearrangeRoutineExercises = '/rearrange-routine-exercises';
  static const viewRoutine = '/view-routine';
  static const recordWorkout = '/record-workout';
}

final routerConfig = GoRouter(
  navigatorKey: Constants.navigatorKey,
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: Routes.signup,
      name: Routes.signup,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: Routes.login,
      name: Routes.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: Routes.homeBase,
      name: Routes.homeBase,
      builder: (context, state) => HomeBaseScreen(),
    ),
    GoRoute(
      path: Routes.selectRoutineExercises,
      name: Routes.selectRoutineExercises,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return SelectRoutineExercisesScreen(
          name: data['name'],
          routineForEdit: data['routineForEdit'],
        );
      },
    ),
    GoRoute(
      path: Routes.rearrangeRoutineExercises,
      name: Routes.rearrangeRoutineExercises,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return RearrangeRoutineExercisesScreen(
          name: data["name"],
          selectedExercises: data["exercises"],
          routineForEditId: data["routineForEditId"],
        );
      },
    ),
    GoRoute(
      path: Routes.viewRoutine,
      name: Routes.viewRoutine,
      builder: (context, state) => ViewRoutine(
        routine: state.extra as Routine,
      ),
    ),
    GoRoute(
      path: Routes.recordWorkout,
      name: Routes.recordWorkout,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return RecordWorkoutScreen(
          routine: data['routine'],
        );
      },
    ),
  ],
);
