import 'package:flutter/material.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

class ItemExercise extends StatelessWidget {
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final Exercise exercise;
  final bool showButtons;

  const ItemExercise({
    super.key,
    required this.exercise,
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
              exercise.name,
            ),
          ),
          Text(
            " ( ${exercise.setsData} )",
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
