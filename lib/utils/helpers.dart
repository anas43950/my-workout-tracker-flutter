import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

final timeSeparator = " : ";

void showSuccessSnackBar(BuildContext context, String message) {
  snackBar(
    context,
    title: message,
    backgroundColor: Colors.green,
    duration: const Duration(milliseconds: 1500),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  snackBar(
    context,
    title: message,
    backgroundColor: Colors.red,
    duration: const Duration(milliseconds: 1500),
  );
}

String getTimeText(int seconds) {
  var duration = Duration(seconds: seconds);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String sDuration =
      "${twoDigits(duration.inHours) + timeSeparator}"
      "${twoDigits(duration.inMinutes.remainder(60)) + timeSeparator}"
      "${twoDigits(duration.inSeconds.remainder(60))}";

  return sDuration;
}
