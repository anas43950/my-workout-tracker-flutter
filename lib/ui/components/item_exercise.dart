import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide white, black;
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/ui/theme/colors.dart';

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
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          12.width,
          Expanded(
            child: Text(
              exercise.name,
            ),
          ),
          Text(
            " ( ${exercise.setsData} )",
          ),
          if (showButtons) ...[
            5.width,
            PopupMenuButton(
              color: white,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  onTap: onEditPressed,
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  onTap: onDeletePressed,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
              child: Icon(
                FluentIcons.more_vertical_16_filled,
                size: 20,
              ),
            ),
            4.width,
          ] else
            12.width,
        ],
      ),
    );
  }
}
