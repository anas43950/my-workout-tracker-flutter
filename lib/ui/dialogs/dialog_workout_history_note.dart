import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class DialogWorkoutHistoryNote extends StatelessWidget {
  final String note;

  const DialogWorkoutHistoryNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Note from last workout:",
              style: AppTextStyles.bodySmall.copyWith(fontSize: 13),
            ),
            10.height,
            Text(
              note,
              style: AppTextStyles.label,
            ),
            10.height,
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
              child: Text(
                "Dismiss",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
