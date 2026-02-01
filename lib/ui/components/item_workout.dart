import 'package:flutter/material.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

import 'bottom_sheets/bottom_sheet_add_workout.dart';

class ItemWorkout extends StatelessWidget {
  final Workout workout;

  const ItemWorkout({super.key, required this.workout});

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
          ClickableText(
            textColor: Colors.red,
            text: "Delete",
            onTap: () {},
          ),

          ClickableText(
            text: "Edit",
            onTap: () {
              showModalBottomSheet(
                scrollControlDisabledMaxHeightRatio: 9 / 15.5,
                context: context,
                builder: (_) => BottomSheetAddWorkout(workoutForEdit: workout),
              );
            },
          ),
        ],
      ),
    );
  }
}
