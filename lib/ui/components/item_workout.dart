import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkout extends StatefulWidget {
  final Workout workout;

  const ItemWorkout({super.key, required this.workout});

  @override
  State<ItemWorkout> createState() => _ItemWorkoutState();
}

class _ItemWorkoutState extends State<ItemWorkout> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text(
                  DateFormat("EEE, dd MMM yyyy").format(widget.workout.createdAt),
                  style: AppTextStyles.bodySmall,
                ),
                Spacer(),
                Text(
                  "W x R",
                  style: AppTextStyles.bodySmall,
                ),
                10.width,
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => setState(() => expanded = !expanded),
                  child: Icon(
                    expanded ? FluentIcons.eye_off_16_filled : FluentIcons.eye_12_filled,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            itemBuilder: (_, i) => _WorkoutChild(
              workoutChild: widget.workout.logs[i],
              index: i,
              showSets: expanded,
            ),
            separatorBuilder: (_, i) => Divider(height: 0),
            itemCount: widget.workout.logs.length,
          ),
          if (widget.workout.note != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                widget.workout.note!,
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WorkoutChild extends StatelessWidget {
  final WorkoutChild workoutChild;
  final int index;
  final bool showSets;

  const _WorkoutChild({required this.workoutChild, required this.index, required this.showSets});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Row(
        spacing: 10,
        children: [
          Text(
            (index + 1).toString(),
            style: AppTextStyles.bodySmall,
          ),
          Expanded(
            child: Text(
              workoutChild.exerciseName,
            ),
          ),
          if (showSets)
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
                                fontSize: 13,
                                height: 0.9,
                              ),
                            ),
                            if (e.hasDropSet) ...[
                              5.height,
                              Text(
                                e.dropSetRepsData,
                                style: AppTextStyles.bodySmall.copyWith(height: 0.9),
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
      ),
    );
  }
}
