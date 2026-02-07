import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';

class ViewRoutine extends StatelessWidget {
  final Routine routine;

  const ViewRoutine({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: "${routine.name} Routine",
        showBackBtn: true,
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pushNamed(
                  Routes.selectWorkoutsForRoutine,
                  extra: {
                    'name': routine.name,
                    'routineForEdit': routine,
                  },
                );
              },
              icon: Icon(
                FluentIcons.edit_12_filled,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => ItemWorkout(
          workout: routine.workouts[i],
          showButtons: false,
        ),
        itemCount: routine.workouts.length,
      ),
    );
  }
}
