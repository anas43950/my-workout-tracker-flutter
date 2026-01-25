import 'package:go_router/go_router.dart';
import 'package:workout_tracker/ui/screens/add_routine_screen.dart';
import 'package:workout_tracker/ui/screens/auth/login_screen.dart';
import 'package:workout_tracker/ui/screens/auth/sign_up_screen.dart';
import 'package:workout_tracker/ui/screens/main/home_base_screen.dart';
import 'package:workout_tracker/ui/screens/splash_screen.dart';

class Routes {
  Routes._();

  static const homeBase = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const addRoutine = '/add-routine';
}

final routerConfig = GoRouter(
  initialLocation: Routes.homeBase,
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
      path: Routes.addRoutine,
      name: Routes.addRoutine,
      builder: (context, state) => AddRoutineScreen(),
    ),
  ],
);
