import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
