import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;

  const SearchTextField({
    super.key,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: grey),
        prefixIcon: Icon(
          FluentIcons.search_12_regular,
          color: lightGrey,
        ),
        suffixIcon: IconButton(
          onPressed: () => controller.clear(),
          icon: Icon(
            FluentIcons.dismiss_12_filled,
            size: 18,
          ),
        ),
        contentPadding: EdgeInsets.all(13),
      ),
      controller: controller,
    );
  }
}
