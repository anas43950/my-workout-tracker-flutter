import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(Dimensions.bodyPadding, Dimensions.bodyPadding, Dimensions.bodyPadding, 0),
          child: body,
        ),
      ),
    );
  }
}
