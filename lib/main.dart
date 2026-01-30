import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/register_cubits.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/theme/app_theme.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  await SharedPrefUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: RegisterCubits().providers,
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            routerConfig: routerConfig,
          );
        },
      ),
    );
  }
}
