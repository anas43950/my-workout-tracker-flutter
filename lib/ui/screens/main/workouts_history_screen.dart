import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';

class WorkoutsHistoryScreen extends StatelessWidget {
  const WorkoutsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Your past recorded workouts will appear here",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) => ItemWorkout(),
              separatorBuilder: (_, i) => 10.height,
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
