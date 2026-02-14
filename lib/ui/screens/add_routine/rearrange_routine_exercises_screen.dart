import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/data/cubits/routines/manage_routine_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_rearrange_exercise.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/utils/helpers.dart';

class RearrangeRoutineExercisesScreen extends StatefulWidget {
  final String name;
  final List<Exercise> selectedExercises;
  final int? routineForEditId;

  const RearrangeRoutineExercisesScreen({
    super.key,
    required this.selectedExercises,
    required this.name,
    this.routineForEditId,
  });

  @override
  State<RearrangeRoutineExercisesScreen> createState() => _RearrangeRoutineExercisesScreenState();
}

class _RearrangeRoutineExercisesScreenState extends State<RearrangeRoutineExercisesScreen> {
  late final List<Exercise> rearrangedExercises;
  late final bool isEditing;

  @override
  void initState() {
    super.initState();
    rearrangedExercises = widget.selectedExercises;
    isEditing = widget.routineForEditId != null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn: true,
      title: "Set the order of exercises",
      padding: EdgeInsets.all(20),
      body: BlocConsumer<ManageRoutineCubit, ManageRoutineState>(
        listener: (context, state) {
          if (state is SaveRoutineSuccess) {
            while (context.canPop()) {
              context.pop();
            }
          }
          if (state is SaveRoutineFail) {
            showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  proxyDecorator: proxyDecorator,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = rearrangedExercises.removeAt(oldIndex);
                      rearrangedExercises.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, i) => ItemRearrangeExercise(
                    key: Key(i.toString()),
                    name: rearrangedExercises[i].name,
                    index: i,
                    trailing: ReorderableDragStartListener(
                      key: ValueKey<int>(i),
                      index: i,
                      child: Icon(FluentIcons.re_order_dots_vertical_16_regular),
                    ),
                  ),
                  itemCount: rearrangedExercises.length,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (state is SaveRoutineInProgress) return;
                  if (isEditing) {
                    context.read<ManageRoutineCubit>().updateRoutine(
                      id: widget.routineForEditId!,
                      exercises: rearrangedExercises,
                      name: widget.name,
                    );
                  } else {
                    context.read<ManageRoutineCubit>().addRoutine(
                      name: widget.name,
                      exercises: rearrangedExercises,
                    );
                  }
                },
                child: state is SaveRoutineInProgress ? CustomLoader() : Text("Done"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) => AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      return Material(
        color: Colors.transparent,
        child: AnimatedScale(
          scale: 1.04,
          duration: Duration(milliseconds: 400),
          child: child,
        ),
      );
    },
    child: child,
  );
}
