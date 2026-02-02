import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/workout/workouts_list_cubit.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_select_workout.dart';
import 'package:workout_tracker/utils/logger.dart';

class SelectWorkoutsForRoutineScreen extends StatefulWidget {
  const SelectWorkoutsForRoutineScreen({super.key});

  @override
  State<SelectWorkoutsForRoutineScreen> createState() => _SelectWorkoutsForRoutineScreenState();
}

class _SelectWorkoutsForRoutineScreenState extends State<SelectWorkoutsForRoutineScreen> {
  List<Workout> allWorkouts = [];
  List<Workout> selectedWorkouts = [];

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
            child: BlocBuilder<WorkoutsListCubit, WorkoutsListState>(
              builder: (context, state) {
                if (state is FetchWorkoutsSuccess) {
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      final workout = state.workouts[i];
                      return ItemSelectWorkout(
                        name: workout.name,
                        selected: selectedWorkouts.contains(workout),
                        onSelectionChanged: (bool value) {
                          setState(() {
                            if (value) {
                              selectedWorkouts.add(workout);
                            } else {
                              selectedWorkouts.remove(workout);
                            }
                          });
                        },
                      );
                    },
                    itemCount: state.workouts.length,
                  );
                }
                return SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
