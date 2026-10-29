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
import 'package:workout_tracker/ui/components/search_text_field.dart';

class SelectRoutineExercisesScreen extends StatefulWidget {
  final String name;
  final Routine? routineForEdit;

  const SelectRoutineExercisesScreen({super.key, required this.name, this.routineForEdit});

  @override
  State<SelectRoutineExercisesScreen> createState() => _SelectRoutineExercisesScreenState();
}

class _SelectRoutineExercisesScreenState extends State<SelectRoutineExercisesScreen> {
  List<Exercise>? filteredExercises;
  List<Exercise> selectedExercises = [];
  final searchController = TextEditingController();
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    if (widget.routineForEdit != null) {
      selectedExercises.addAll(widget.routineForEdit!.exercises);
    }
    searchController.addListener(() {
      setState(() {
        filteredExercises = context.read<ExercisesListCubit>().filterExercises(searchController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "${widget.name} routine",
      showBackBtn: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchTextField(
            controller: searchController,
            hintText: "Search Exercises",
          ),
          5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Select All"),
              Checkbox(value: selectAll, onChanged: onSelectAllChanged),
            ],
          ),
          5.height,
          Expanded(
            child: BlocBuilder<ExercisesListCubit, ExercisesListState>(
              builder: (context, state) {
                if (state is ExercisesListRefreshed) {
                  final exercises = filteredExercises ?? state.exercises;
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      final exercise = exercises[i];
                      return ItemSelectExercise(
                        name: exercise.name,
                        selected: selectedExercises.any((e) => e.id == exercise.id),
                        onSelectionChanged: (bool value) {
                          onExerciseSelectionChanged(exercise, value);
                        },
                      );
                    },
                    itemCount: exercises.length,
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

  void onSelectAllChanged(bool? value) {
    if (value == null) return;
    if (value) {
      selectedExercises.addAll((context.read<ExercisesListCubit>().state as ExercisesListRefreshed).exercises);
    } else {
      selectedExercises.clear();
    }
    setState(() => selectAll = value);
  }

  void onExerciseSelectionChanged(Exercise exercise, bool selected) {
    setState(() {
      if (selected) {
        selectedExercises.add(exercise);
        if (selectedExercises.length == (context.read<ExercisesListCubit>().state as ExercisesListRefreshed).exercises.length) {
          selectAll = true;
        }
      } else {
        selectedExercises.removeWhere((e) => e.id == exercise.id);
        selectAll = false;
      }
    });
  }
}
