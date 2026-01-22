import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout_record.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';

class PastRecordsScreen extends StatelessWidget {
  const PastRecordsScreen({super.key});

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
          20.height,
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) => ItemWorkoutRecord(),
              separatorBuilder: (_, i) => 10.height,
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
