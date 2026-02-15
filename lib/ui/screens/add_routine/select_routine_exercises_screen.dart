import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/exercises/exercises_list_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_select_exercise.dart';

class SelectRoutineExercisesScreen extends StatefulWidget {
  final String name;
  final Routine? routineForEdit;

  const SelectRoutineExercisesScreen({super.key, required this.name, this.routineForEdit});

  @override
  State<SelectRoutineExercisesScreen> createState() => _SelectRoutineExercisesScreenState();
}

class _SelectRoutineExercisesScreenState extends State<SelectRoutineExercisesScreen> {
  List<Exercise> selectedExercises = [];

  @override
  void initState() {
    super.initState();
    if (widget.routineForEdit != null) {
      selectedExercises.addAll(widget.routineForEdit!.exercises);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Select exercises for Sunday routine",
      showBackBtn: true,
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
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          15.height,
          Expanded(
            child: BlocBuilder<ExercisesListCubit, ExercisesListState>(
              builder: (context, state) {
                if (state is FetchExercisesSuccess) {
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      final exercise = state.exercises[i];
                      return ItemSelectExercise(
                        name: exercise.name,
                        selected: selectedExercises.any((e) => e.id == exercise.id),
                        onSelectionChanged: (bool value) {
                          setState(() {
                            if (value) {
                              selectedExercises.add(exercise);
                            } else {
                              selectedExercises.removeWhere((e) => e.id == exercise.id);
                            }
                          });
                        },
                      );
                    },
                    itemCount: state.exercises.length,
                  );
                }
                return SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  Routes.rearrangeRoutineExercises,
                  extra: {
                    "name": widget.name,
                    "exercises": selectedExercises,
                    "routineForEditId": widget.routineForEdit?.id,
                  },
                );
              },
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
