import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  void clearStackAndNavigate(String location) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    pushReplacement(location);
  }

  Future<dynamic> dialog(Widget dialog) async{
    final result = await showDialog(
      context: this,
      builder: (context) => dialog,
    );
    return result;
  }
}
