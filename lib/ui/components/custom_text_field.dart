import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? allowDigitsOnly;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? formatters;
  final int? maxLines;

  CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.allowDigitsOnly,
    this.validator,
    this.formatters,
    this.maxLines,
  }) {
    if (allowDigitsOnly == true && formatters != null) {
      throw ArgumentError("Cannot set both allowDigitsOnly and formatters");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      keyboardType: allowDigitsOnly == true ? TextInputType.number : null,
      inputFormatters: allowDigitsOnly == true ? [FilteringTextInputFormatter.digitsOnly] : formatters,
    );
  }
}
