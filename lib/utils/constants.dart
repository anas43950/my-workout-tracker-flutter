import 'package:flutter/material.dart';

const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
const weekdaysFull = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

class Constants {
  Constants._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AppStrings {
  AppStrings._();

  static final token = 'token';
  static final user = 'user';
}
