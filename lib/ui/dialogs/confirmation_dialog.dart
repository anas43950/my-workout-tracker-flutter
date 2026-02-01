import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/ui/components/small_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback onConfirmed;
  final VoidCallback? onCancelled;

  const ConfirmationDialog({
    super.key,
    this.title,
    required this.message,
    required this.onConfirmed,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              6.height,
            ],
            Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
            15.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 15,
              children: [
                SmallButton(
                  title: "No",
                  onPressed: () {
                    context.pop();
                  },
                  border: true,
                ),
                SmallButton(
                  title: "Yes",
                  onPressed: onConfirmed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
