import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  const BaseScaffold({super.key, required this.body, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(Dimensions.bodyPadding),
        child: body,
      ),
    );
  }
}
