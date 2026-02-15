import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/exercises/exercises_list_cubit.dart';
import 'package:workout_tracker/data/cubits/exercises/manage_exercise_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/ui/bottom_sheets/bottom_sheet_add_exercise.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_exercise.dart';
import 'package:workout_tracker/ui/dialogs/confirmation_dialog.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  List<Exercise> exercises = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            scrollControlDisabledMaxHeightRatio: 9 / 15.5,
            context: context,
            builder: (_) => BottomSheetAddExercise(),
          );
        },
        child: Icon(FluentIcons.add_12_filled),
      ),
      title: "Your added exercises will appear here",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search exercises...",
              hintStyle: TextStyle(color: grey),
              prefixIcon: Icon(
                FluentIcons.search_12_regular,
                color: lightGrey,
              ),
            ),
          ),
          Divider(height: 40),
          Expanded(
            child: BlocListener<ManageExerciseCubit, ManageExerciseState>(
              listener: (context, state) {
                if (state is DeleteExerciseFail) {
                  showErrorSnackBar(context, state.message);
                }
              },
              child: BlocBuilder<ExercisesListCubit, ExercisesListState>(
                builder: (context, state) {
                  if (state is FetchExercisesInProgress) {
                    return Loader();
                  } else if (state is FetchExercisesFail) {
                    return Text(state.message);
                  } else if (state is FetchExercisesSuccess) {
                    exercises = state.exercises;
                    return exercises.isEmpty
                        ? Center(child: Text("No exercises added yet"))
                        : ListView.builder(
                            itemBuilder: (_, i) {
                              final exercise = exercises[i];
                              return ItemExercise(
                                exercise: exercise,
                                onEditPressed: () {
                                  showModalBottomSheet(
                                    scrollControlDisabledMaxHeightRatio: 9 / 15.5,
                                    context: context,
                                    builder: (_) => BottomSheetAddExercise(exercise: exercise),
                                  );
                                },
                                onDeletePressed: () {
                                  context.dialog(
                                    ConfirmationDialog(
                                      title: "Delete this exercise?",
                                      message: "This exercise and it's history will be permanently deleted",
                                      onConfirmed: () {
                                        context.pop();
                                        context.read<ManageExerciseCubit>().deleteExercise(id: exercise.id);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: exercises.length,
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
