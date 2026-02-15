import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/components/centered_tri_widget.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final Widget? trailing;
  final String? title;
  final bool? centerTitle;
  final bool? showBackBtn;
  final height = 56.0;
  final VoidCallback? onBackPressed;

  CustomAppBar({
    super.key,
    this.title,
    this.centerTitle,
    this.showBackBtn,
    this.titleWidget,
    this.trailing,
    this.onBackPressed,
  }) {
    if (title != null && titleWidget != null) {
      throw Exception("Can't pass both title and customTitleWidget");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: CenteredTriWidget(
          leading: showBackBtn == true ? CustomBackButton(onPressed: onBackPressed) : null,
          center: titleWidget ?? (title != null ? Text(title!, style: TextStyle(fontSize: 16)) : null),
          trailing: trailing,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
