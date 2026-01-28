import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final String? title;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.title,
    this.appBar,
    this.padding,
  }) {
    if (title != null && appBar != null) {
      throw Exception("Can't pass both title and appBar");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = context.canPop();
    return Scaffold(
      appBar:
          appBar ??
          (title != null
              ? CustomAppBar(
                  title: title!,
                  showBackBtn: canPop,
                )
              : null),
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding:
              padding ??
              EdgeInsets.fromLTRB(
                Dimensions.bodyPadding,
                title != null ? 0 : Dimensions.bodyPadding,
                Dimensions.bodyPadding,
                0,
              ),
          child: body,
        ),
      ),
    );
  }
}
