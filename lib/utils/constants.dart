import 'package:flutter/material.dart';

const weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
]; // Starting from monday here as dart's week starts from monday


final sortedWeekdays = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];

String get todayWeekDay => weekdays[DateTime.now().weekday - 1];

class Constants {
  Constants._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final int MIN_PASS_LENGTH = 6;
}

class AppStrings {
  AppStrings._();

  static final token = 'token';
  static final userFullName = 'user_full_name';
}
