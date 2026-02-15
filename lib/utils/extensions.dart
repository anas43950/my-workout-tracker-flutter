import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension CustomContextExtensions on BuildContext {
  void clearStackAndNavigate(String location) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location);
  }

  Future<dynamic> dialog(Widget dialog) async {
    final result = await showDialog(
      context: this,
      builder: (context) => dialog,
    );
    return result;
  }

  void popUntil(String routePath, {dynamic result}) {
    while (GoRouter.of(this).routerDelegate.currentConfiguration.matches.last.matchedLocation != routePath) {
      if (!canPop()) {
        return;
      }
      pop(result);
    }
  }
}

extension DoubleExtensions on double {
  String get formatToString => this % 1 == 0 ? toInt().toString() : toString();
}

extension StringExtension on String {
  String? get textOrNull => trim().isEmpty ? null : trim();
}
