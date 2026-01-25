import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

class ItemWorkout extends StatelessWidget {
  const ItemWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Flat Bench Press",
            ),
          ),
          ClickableText(
            textColor: Colors.red,
            text: "Delete",
            onTap: () {},
          ),
          10.width,
          ClickableText(
            text: "Edit",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
