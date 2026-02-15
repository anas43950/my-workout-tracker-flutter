import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkout extends StatelessWidget {
  final Workout workout;

  const ItemWorkout({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("dd MMM, yyyy").format(workout.createdAt),
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  "R - W",
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                itemBuilder: (_, i) => _WorkoutChild(workoutChild: workout.logs[i], index: i),
                separatorBuilder: (_, i) => Divider(height: 0),
                itemCount: workout.logs.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkoutChild extends StatefulWidget {
  final WorkoutChild workoutChild;
  final int index;

  const _WorkoutChild({required this.workoutChild, required this.index});

  @override
  State<_WorkoutChild> createState() => _WorkoutChildState();
}

class _WorkoutChildState extends State<_WorkoutChild> {
  bool expanded = false;
  final duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => expanded = !expanded),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: duration,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            Text(
              (widget.index + 1).toString(),
              style: AppTextStyles.bodySmall,
            ),
            10.width,
            Expanded(
              child: Text(
                widget.workoutChild.exerciseName,
              ),
            ),
            AnimatedAlign(
              duration: duration,
              alignment: Alignment.centerRight,
              heightFactor: expanded ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.workoutChild.sets
                    .map(
                      (e) => AnimatedDefaultTextStyle(
                        style: TextStyle(
                          color: expanded ? Colors.black : Colors.transparent,
                          fontSize: expanded ? 14 : 8,
                          height: 1.5,
                        ),
                        duration: duration,
                        child: Text(e.repsData),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
