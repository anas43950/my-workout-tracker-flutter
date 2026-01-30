import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';

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
    return CustomScaffold(
      body: Center(
        child: Text(
          "Let's track your workouts!",
          style: AppTextStyles.heading,
        ),
      ),
    );
  }

  void _timer() {
    timer ??= Timer(const Duration(seconds: 1), () {
      if (SharedPrefUtils.getString(AppStrings.token) != null) {
        context.goNamed(Routes.homeBase);
      } else {
        context.goNamed(Routes.login);
      }
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
