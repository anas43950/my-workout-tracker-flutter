import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const ClickableText({super.key, required this.text, required this.onTap, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.blue),
      ),
    );
  }
}
