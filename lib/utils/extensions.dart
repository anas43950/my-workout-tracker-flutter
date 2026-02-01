import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  void clearStackAndNavigate(String location) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    pushReplacement(location);
  }

  void dialog(Widget dialog) {
    showDialog(
      context: this,
      builder: (context) => dialog,
    );
  }
}
