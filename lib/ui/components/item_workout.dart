import 'package:flutter/material.dart';
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
        spacing: 10,
        children: [
          Expanded(
            child: Row(
              spacing: 10,
              children: [
                Text(
                  "Flat Bench Press",
                ),
                Text(
                  "- 3 x 10-12",
                ),
              ],
            ),
          ),
          ClickableText(
            textColor: Colors.red,
            text: "Delete",
            onTap: () {},
          ),

          ClickableText(
            text: "Edit",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
