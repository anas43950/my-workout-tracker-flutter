import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/workout/manage_workout_cubit.dart';
import 'package:workout_tracker/data/cubits/workout/workouts_list_cubit.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/bottom_sheets/bottom_sheet_add_workout.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';
import 'package:workout_tracker/ui/dialogs/confirmation_dialog.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  List<Workout> workouts = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            scrollControlDisabledMaxHeightRatio: 9 / 15.5,
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
            child: BlocListener<ManageWorkoutCubit, ManageWorkoutState>(
              listener: (context, state) {
                // if (state is AddWorkoutSuccess) {
                //   setState(() => workouts.add(state.workout));
                // }
                // if (state is UpdateWorkoutSuccess) {
                //   setState(
                //     () => workouts[workouts.indexWhere((element) => element.id == state.workout.id)] = state.workout,
                //   );
                // }
                // if (state is DeleteWorkoutSuccess) {
                //   // setState(() => workouts.removeWhere((e) => e.id == state.id));
                // }
                if (state is DeleteWorkoutFail) {
                  showErrorSnackBar(context, state.message);
                }
              },
              child: BlocBuilder<WorkoutsListCubit, WorkoutsListState>(
                builder: (context, state) {
                  if (state is FetchWorkoutsInProgress) {
                    return Loader();
                  } else if (state is FetchWorkoutsFail) {
                    return Text(state.message);
                  } else if (state is FetchWorkoutsSuccess) {
                    workouts = state.workouts;
                    return workouts.isEmpty
                        ? Center(child: Text("No workouts added yet"))
                        : ListView.builder(
                            itemBuilder: (_, i) {
                              final workout = workouts[i];
                              return ItemWorkout(
                                workout: workout,
                                onEditPressed: () {
                                  showModalBottomSheet(
                                    scrollControlDisabledMaxHeightRatio: 9 / 15.5,
                                    context: context,
                                    builder: (_) => BottomSheetAddWorkout(workoutForEdit: workout),
                                  );
                                },
                                onDeletePressed: () {
                                  context.dialog(
                                    ConfirmationDialog(
                                      title: "Delete this workout?",
                                      message: "This workout and it's history will be permanently deleted",
                                      onConfirmed: () {
                                        context.pop();
                                        context.read<ManageWorkoutCubit>().deleteWorkout(id: workout.id);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: workouts.length,
                          );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
