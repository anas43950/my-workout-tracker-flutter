import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/workout_history/record_workout_cubit.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/components/record_workout_page_view_item.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/extensions.dart';

class RecordWorkoutScreen extends StatefulWidget {
  final Routine routine;

  const RecordWorkoutScreen({super.key, required this.routine});

  @override
  State<RecordWorkoutScreen> createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final pageController = PageController();
  late Routine routine;
  late Workout? lastHistory;
  List<WorkoutChild> logs = [];
  int currentExerciseIndex = 0;

  @override
  void initState() {
    super.initState();

    routine = widget.routine;
    context.read<RecordWorkoutCubit>().changeExercise(routine.exercises.first.id);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        showBackBtn: true,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text(
              "Today's routine :",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              routine.name,
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          25.height,
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (_, i) => RecordWorkoutPageViewItem(
                exercise: routine.exercises[i],
                index: i,
              ),
              itemCount: routine.exercises.length,
              onPageChanged: (index) {
                context.read<RecordWorkoutCubit>().changeExercise(routine.exercises[index].id);
                setState(() => currentExerciseIndex = index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 10,
              children: [
                if (currentExerciseIndex != 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => changePage(toNext: false),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: lightGrey,
                      ),
                      child: Text("Previous"),
                    ),
                  ),
                Expanded(
                  child: currentExerciseIndex == routine.exercises.length - 1
                      ? ElevatedButton(
                          onPressed: onCompleteTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text("Complete"),
                        )
                      : ElevatedButton(
                          onPressed: () => changePage(toNext: true),
                          child: Text("Next"),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onCompleteTap() {
    context.dialog(
      DialogAddWorkoutNote(),
    );
  }

  void changePage({required bool toNext}) {
    final duration = const Duration(milliseconds: 400);
    final curve = Curves.linearToEaseOut;

    if (toNext) {
      pageController.nextPage(
        duration: duration,
        curve: curve,
      );
    } else {
      pageController.previousPage(
        duration: duration,
        curve: curve,
      );
    }
  }
}

class DialogAddWorkoutNote extends StatelessWidget {
  const DialogAddWorkoutNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: "Enter a note (optional)",
              maxLines: 3,
            ),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text("Save Workout"),
            ),
          ],
        ),
      ),
    );
  }
}
