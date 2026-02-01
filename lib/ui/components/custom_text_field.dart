import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? allowDigitsOnly;
  final String? Function(String? value)? validator;

  const CustomTextField({super.key, this.hintText, this.controller, this.allowDigitsOnly, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      keyboardType: allowDigitsOnly == true ? TextInputType.number : null,
      inputFormatters: allowDigitsOnly == true ? [FilteringTextInputFormatter.digitsOnly] : null,
    );
  }
}
