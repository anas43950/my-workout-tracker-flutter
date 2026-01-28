import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/bottom_sheets/bottom_sheet_add_workout.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => BottomSheetAddWorkout(),
          );
        },
        child: Icon(FluentIcons.add_12_filled),
      ),
      title: "Your added workouts will appear here",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search workouts...",
              hintStyle: TextStyle(color: grey),
              prefixIcon: Icon(
                FluentIcons.search_12_regular,
                color: lightGrey,
              ),
            ),
          ),
          Divider(height: 40),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => ItemWorkout(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
