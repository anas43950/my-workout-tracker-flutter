import 'package:flutter/material.dart';

const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
const weekdaysFull = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

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
