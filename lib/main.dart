import 'package:flutter/material.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: routerConfig,
    );
  }
}