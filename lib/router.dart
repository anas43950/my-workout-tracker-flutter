import 'package:go_router/go_router.dart';
import 'package:workout_tracker/ui/screens/auth/login_screen.dart';
import 'package:workout_tracker/ui/screens/auth/sign_up_screen.dart';
import 'package:workout_tracker/ui/screens/home_screen.dart';
import 'package:workout_tracker/ui/screens/splash_screen.dart';

class Routes {
  Routes._();

  static const home = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
}

final routerConfig = GoRouter(
  initialLocation: Routes.signup,
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
      path: Routes.home,
      name: Routes.home,
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
