import 'package:flutter/material.dart';

const weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
]; // Starting from monday here as dart's week starts from monday
final wdPos = {
  'Sunday': 0,
  'Monday': 1,
  'Tuesday': 2,
  'Wednesday': 3,
  'Thursday': 4,
  'Friday': 5,
  'Saturday': 6,
};

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
