import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/theme/colors.dart';

class SmallButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool? border;

  const SmallButton({super.key, required this.title, required this.onPressed, this.border});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: border == true ? white : null,
        shape: border == true
            ? RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(15),
              )
            : null,
        foregroundColor: border == true ? Colors.black : null,
        padding: EdgeInsets.all(10),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
