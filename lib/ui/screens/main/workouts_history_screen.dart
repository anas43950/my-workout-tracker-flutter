import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/workouts/workouts_list_cubit.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout.dart';
import 'package:workout_tracker/ui/components/loader.dart';

class WorkoutsHistoryScreen extends StatelessWidget {
  const WorkoutsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Your past recorded workouts will appear here",
      body: BlocBuilder<WorkoutsListCubit, WorkoutsListState>(
        builder: (context, state) {
          if (state is FetchWorkoutsInProgress) {
            return Center(child: CustomLoader(color: Colors.black));
          }
          if (state is FetchWorkoutsFail) {
            return Center(child: Text(state.message));
          }
          if (state is FetchWorkoutsSuccess) {
            final workouts = state.workouts;
            if (workouts.isEmpty) {
              return Center(child: Text("No workouts recorded yet"));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, i) => ItemWorkout(
                      workout: workouts[i],
                    ),
                    separatorBuilder: (_, i) => 10.height,
                    itemCount: workouts.length,
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
