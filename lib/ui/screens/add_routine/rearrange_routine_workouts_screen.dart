import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/data/cubits/routines/manage_routine_cubit.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_rearrange_workout.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/utils/helpers.dart';

class RearrangeRoutineWorkoutsScreen extends StatefulWidget {
  final String name;
  final List<Workout> selectedWorkouts;
  final int? routineForEditId;

  const RearrangeRoutineWorkoutsScreen({
    super.key,
    required this.selectedWorkouts,
    required this.name,
    this.routineForEditId,
  });

  @override
  State<RearrangeRoutineWorkoutsScreen> createState() => _RearrangeRoutineWorkoutsScreenState();
}

class _RearrangeRoutineWorkoutsScreenState extends State<RearrangeRoutineWorkoutsScreen> {
  late final List<Workout> rearrangedWorkouts;
  late final bool isEditing;

  @override
  void initState() {
    super.initState();
    rearrangedWorkouts = widget.selectedWorkouts;
    isEditing = widget.routineForEditId != null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn: true,
      title: "Set the order of workouts",
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
                      final item = rearrangedWorkouts.removeAt(oldIndex);
                      rearrangedWorkouts.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, i) => ItemRearrangeWorkout(
                    key: Key(i.toString()),
                    name: rearrangedWorkouts[i].name,
                    index: i,
                    trailing: ReorderableDragStartListener(
                      key: ValueKey<int>(i),
                      index: i,
                      child: Icon(FluentIcons.re_order_dots_vertical_16_regular),
                    ),
                  ),
                  itemCount: rearrangedWorkouts.length,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (state is SaveRoutineInProgress) return;
                  if (isEditing) {
                    context.read<ManageRoutineCubit>().updateRoutine(
                      id: widget.routineForEditId!,
                      workouts: rearrangedWorkouts,
                      name: widget.name,
                    );
                  } else {
                    context.read<ManageRoutineCubit>().addRoutine(
                      name: widget.name,
                      workouts: rearrangedWorkouts,
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
