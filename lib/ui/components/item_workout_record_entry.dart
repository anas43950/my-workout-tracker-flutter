import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_history_child.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkoutRecordEntry extends StatelessWidget {
  final int index;
  final Workout workout;
  final WorkoutHistoryChild? lastHistoryChild;
  final String? lastHistoryDate;

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
                      5.height,
                      if (lastHistoryChild == null)
                        Expanded(
                          child: Center(
                            child: Text(
                              lastHistoryDate == null ? "No history found" : "Not Found",
                              // If last history date is null, it means there is no workout history for the selected routine's day
                              // Else if only last history child is null, it means there is a history, but no history child for the current workout
                              style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      else ...[
                        Text("50 kgs - 10 reps"),
                        Text("50 kgs - 10 reps"),
                        Text("50 kgs - 10 reps"),
                      ],
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Text(
                        "Today's progress",
                        style: AppTextStyles.label,
                      ),
                      5.height,
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 40),
          Text(
            "New set entry",
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          15.height,
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
              FloatingActionButton(
                heroTag: null,
                onPressed: () {},
                backgroundColor: Colors.blueAccent,
                child: Icon(FluentIcons.add_12_filled),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
