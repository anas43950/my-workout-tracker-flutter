import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool? allowDigitsOnly;
  final String? Function(String? value)? validator;

  const TextFieldWithLabel({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.allowDigitsOnly,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          allowDigitsOnly: allowDigitsOnly,
          validator: validator,
        ),
      ],
    );
  }
}
