import 'package:flutter/material.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

class ItemWorkout extends StatelessWidget {
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final Workout workout;
  final bool showButtons;

  const ItemWorkout({
    super.key,
    required this.workout,
    this.onEditPressed,
    this.onDeletePressed,
    this.showButtons = true,
  });

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
            child: Text(
              workout.name,
            ),
          ),
          Text(
            " ( ${workout.setsData} )",
          ),
          if (showButtons) ...[
            ClickableText(
              textColor: Colors.red,
              text: "Delete",
              onTap: onDeletePressed,
            ),
            ClickableText(
              text: "Edit",
              onTap: onEditPressed,
            ),
          ],
        ],
      ),
    );
  }
}
