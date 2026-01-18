import 'package:go_router/go_router.dart';
import 'package:workout_tracker/ui/screens/auth/login_screen.dart';
import 'package:workout_tracker/ui/screens/splash_screen.dart';

class Routes {
  Routes._();

  static const home = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
}

final routerConfig = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: Routes.login,
      name: Routes.login,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
