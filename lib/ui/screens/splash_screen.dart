import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Let's track your workouts!",
          style: TextStyles.heading,
        ),
      ),
    );
  }

  void _timer() {
    timer ??= Timer(const Duration(seconds: 1), () {
      context.goNamed(Routes.login);
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeTimer();
  }

  void disposeTimer() {
    timer?.cancel();
    timer = null;
  }
}
