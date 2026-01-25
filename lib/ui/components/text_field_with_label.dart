import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;

  const TextFieldWithLabel({super.key, required this.label, this.hintText});

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
        TextFormField(
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
