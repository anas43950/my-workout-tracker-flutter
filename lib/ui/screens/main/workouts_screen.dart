import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(FluentIcons.add_12_filled),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Workouts you added will appear here",
          ),
          15.height,
          TextField(
            decoration: InputDecoration(
              hintText: "Search workouts...",
              hintStyle: TextStyle(color: grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightGrey),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          20.height,
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
