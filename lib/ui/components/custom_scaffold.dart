import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/ui/theme/colors.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final String? title;

  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPop = context.canPop();
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(
                title!,
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: white,
              surfaceTintColor: white,
              leading: canPop
                  ? IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        FluentIcons.chevron_left_12_regular,
                      ),
                    )
                  : null,
              titleSpacing: canPop ? 0 : null,
            )
          : null,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
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
