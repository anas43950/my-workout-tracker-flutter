import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_select_workout.dart';

class AddRoutineScreen extends StatelessWidget {
  const AddRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Select workouts for Sunday routine",
      showBackBtn: true,
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
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          // Divider(height: 50),
          15.height,
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => ItemSelectWorkout(
                selected: i < 5,
                onSelectionChanged: (bool value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
