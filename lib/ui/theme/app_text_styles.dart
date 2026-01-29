import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTextStyles {
  AppTextStyles._();

  static final heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: black,
  );

  static final subHeading = TextStyle(
    fontSize: 18,
    color: black,
  );

  static final label = TextStyle(fontSize: 15);

  static final labelMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final bodyMedium = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static final bodySmall = TextStyle(
    fontSize: 12,
    color: grey,
  );
}
