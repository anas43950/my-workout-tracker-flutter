import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';

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
        children: [
          Text("Workouts"),
        ],
      ),
    );
  }
}
