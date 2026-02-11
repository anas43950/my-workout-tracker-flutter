import 'package:flutter/material.dart';

const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

String get todayWeekDay => weekdays[DateTime.now().weekday];

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
