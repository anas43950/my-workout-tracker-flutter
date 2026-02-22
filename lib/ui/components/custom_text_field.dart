import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? allowDigitsOnly;
  final String? Function(String? value)? validator;
  final int? maxLines;
  final bool? changeToDoneKey;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.allowDigitsOnly,
    this.validator,
    this.maxLines,
    this.changeToDoneKey,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: padding, hintStyle: TextStyle(fontSize: 14)),
      keyboardType: allowDigitsOnly == true ? TextInputType.number : null,
      textInputAction: changeToDoneKey == true ? TextInputAction.done : TextInputAction.next,
    );
  }
}
