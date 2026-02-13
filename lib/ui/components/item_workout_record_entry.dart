import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_history_child.dart';
import 'package:workout_tracker/data/models/workout_history_set.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkoutRecordEntry extends StatelessWidget {
  final int index;
  final Workout workout;
  final WorkoutHistoryChild? lastHistoryChild;
  final String? lastHistoryDate;

  // If last history date is null, it means there is no workout history for the selected routine's day
  // If last history date is not null, and only last history child is null, it means there is a history, but no history child for the current workout

  const ItemWorkoutRecordEntry({
    super.key,
    required this.workout,
    required this.index,
    this.lastHistoryChild,
    this.lastHistoryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${index + 1} - ${workout.name}",
                style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                workout.setsData,
                style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Divider(height: 35),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last log",
                            style: AppTextStyles.label,
                          ),
                          if (lastHistoryDate != null)
                            Text(
                              lastHistoryDate!,
                              style: AppTextStyles.bodySmall.copyWith(decoration: TextDecoration.underline),
                            ),
                        ],
                      ),
                      3.height,
                      if (lastHistoryChild != null)
                        Expanded(
                          child: Center(
                            child: Text(
                              lastHistoryDate == null ? "No history found" : "Not Found",
                              style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      else
                        ...List.generate(
                          4,
                          (i) => _ItemWorkoutLog(i, false, null),
                        ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        "Today's progress",
                        style: AppTextStyles.label,
                      ),
                      5.height,
                      ...List.generate(
                        4,
                        (i) => _ItemWorkoutLog(i, i == 3, null),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 40),
          Row(
            spacing: 15,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Main working set",
                      style: AppTextStyles.label,
                      textAlign: TextAlign.center,
                    ),
                    10.height,
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Weight"),
                            // validator: (email) => Validators.emailValidator(email),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Reps"),
                            // validator: (email) => Validators.emailValidator(email),
                          ),
                        ),
                      ],
                    ),
                    30.height,
                    Text(
                      "Drop set (Optional)",
                      style: AppTextStyles.label,
                      textAlign: TextAlign.center,
                    ),
                    10.height,
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Weight"),
                            // validator: (email) => Validators.emailValidator(email),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Reps"),
                            // validator: (email) => Validators.emailValidator(email),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          15.height,
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: Text("Enter"),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemWorkoutLog extends StatelessWidget {
  final int index;
  final bool showRemoveButton;
  final WorkoutHistorySet set;
  final VoidCallback? onRemoveTap;

  const _ItemWorkoutLog(
    this.index,
    this.showRemoveButton,
    this.set,
    this.onRemoveTap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            "${index + 1} -  ",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(set.repsData),
                if (set.hasDropSet)
                  Text(
                    set.dropSetRepsData,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                  ),
              ],
            ),
          ),
          if (showRemoveButton) ...[
            5.width,
            GestureDetector(
              onTap: onRemoveTap,
              child: Icon(
                FluentIcons.subtract_square_16_filled,
                color: Colors.redAccent,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
