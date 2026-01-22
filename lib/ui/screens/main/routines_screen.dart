import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_routine.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            Text("Start Workout"),
            5.width,
            Icon(
              FluentIcons.play_12_filled,
              size: 20,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hello, Anas 👋",
            style: TextStyles.heading,
          ),
          10.height,
          Text(
            "Add a workout routine for each week day",
            style: TextStyles.bodySmall,
          ),
          20.height,
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) => ItemRoutine(index: i),
              separatorBuilder: (_, i) => Divider(
                height: 25,
                thickness: 0.1,
              ),
              itemCount: weekdaysFull.length,
            ),
          ),
        ],
      ),
    );
  }
}
