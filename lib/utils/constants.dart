import 'package:flutter/material.dart';

const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

String get todayWeekDay => weekdays[DateTime.now().weekday - 1];

class Constants {
  Constants._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final int MIN_PASS_LENGTH = 6;
}

class AppStrings {
  AppStrings._();

  static final token = 'token';
  static final user = 'user';
}
