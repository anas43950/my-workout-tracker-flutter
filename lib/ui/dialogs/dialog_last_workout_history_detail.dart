import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/helpers.dart';

class DialogLastWorkoutHistoryDetail extends StatelessWidget {
  final Workout lastHistory;

  const DialogLastWorkoutHistoryDetail({
    super.key,
    required this.lastHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  10.width,
                  Text(
                    DateFormat("EEE, dd MMM yyyy").format(lastHistory.createdAt),
                  ),
                  Spacer(),
                  if (lastHistory.startedAt != null)
                    Text(
                      formatDuration(lastHistory.createdAt.difference(lastHistory.startedAt!)),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                ],
              ),
              Divider(),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                itemBuilder: (_, i) => _WorkoutChild(
                  workoutChild: lastHistory.logs[i],
                  index: i,
                ),
                separatorBuilder: (_, i) => Divider(height: 30),
                itemCount: lastHistory.logs.length,
              ),
              if (lastHistory.note != null) ...[
                Divider(),
                Row(
                  children: [
                    Text(
                      "Note:-  ",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    ),
                    Text(
                      lastHistory.note!,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutChild extends StatelessWidget {
  final WorkoutChild workoutChild;
  final int index;

  const _WorkoutChild({required this.workoutChild, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(
          (index + 1).toString(),
          style: AppTextStyles.bodySmall,
        ),
        Expanded(
          child: Text(
            workoutChild.exerciseName,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: workoutChild.sets
                .expandIndexed(
                  (i, e) => [
                    Column(
                      children: [
                        Text(
                          e.repsData,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        if (e.hasDropSet) ...[
                          5.height,
                          Text(
                            e.dropSetRepsData,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ],
                    ),
                    if (i != workoutChild.sets.length - 1)
                      VerticalDivider(
                        color: Colors.black,
                      ),
                  ],
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
