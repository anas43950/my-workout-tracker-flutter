import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout_history.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Your workout history will appear here",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) => ItemWorkoutHistory(),
              separatorBuilder: (_, i) => 10.height,
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
