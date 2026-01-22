import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TextStyles {
  TextStyles._();

  static final heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final subHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

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
