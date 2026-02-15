import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' hide ContextExtensions;
import 'package:workout_tracker/data/cubits/workouts/manage_workout_cubit.dart';
import 'package:workout_tracker/data/cubits/workouts/record_workout_cubit.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/record_workout_page_view_item.dart';
import 'package:workout_tracker/ui/dialogs/confirmation_dialog.dart';
import 'package:workout_tracker/ui/dialogs/dialog_add_workout_note.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/logger.dart';

class RecordWorkoutScreen extends StatefulWidget {
  final Routine routine;

  const RecordWorkoutScreen({super.key, required this.routine});

  @override
  State<RecordWorkoutScreen> createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final pageController = PageController();
  late Routine routine;
  List<WorkoutChild> logs = [];
  int currentExerciseIndex = 0;
  late final RecordWorkoutCubit rwCubit;

  @override
  void initState() {
    super.initState();

    routine = widget.routine;
    rwCubit = context.read<RecordWorkoutCubit>();
    rwCubit.startWorkout(routine.id, routine.exercises.first.id);
    context.read<ManageWorkoutCubit>().fetchWorkoutForRoutine(routine.id);
  }

  void onBackPressed() {
    if (rwCubit.hasNonEmptySets()) {
      context.dialog(
        ConfirmationDialog(
          message: "Do you want to exit?\nAll of the progress will be lost.",
          onConfirmed: () {
            context.popUntil(Routes.homeBase);
          },
        ),
      );
    } else {
      context.popUntil(Routes.homeBase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) {
        if (value == false) { // If false -> means back button was pressed, if true -> means I invoked pop() myself
          onBackPressed();
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar(
          showBackBtn: true,
          onBackPressed: onBackPressed,
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
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
        padding: EdgeInsets.zero,
        body: MultiBlocListener(
          listeners: [
            BlocListener<RecordWorkoutCubit, RecordWorkoutState>(
              listener: (context, state) {
                if (state is RecordWorkoutCompleted) {
                  context.read<ManageWorkoutCubit>().saveWorkout(state.workout);
                }
              },
            ),
            BlocListener<ManageWorkoutCubit, ManageWorkoutState>(
              listener: (context, state) {
                if (state is SaveWorkoutFail) {
                  showErrorSnackBar(context, state.message);
                }
                if (state is SaveWorkoutSuccess) {
                  context.go(Routes.homeBase);
                }
              },
            ),
          ],
          child: BlocBuilder<ManageWorkoutCubit, ManageWorkoutState>(
            builder: (context, state) {
              if (state is FetchSingleWorkoutInProgress) {
                return Center(
                  child: Text(
                    "Loading history...",
                    style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                );
              }
              if (state is FetchSingleWorkoutFail) {
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              }
              if (state is FetchSingleWorkoutSuccess) {
                Workout? lastHistory = state.workout;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        if (lastHistory == null)
                          Text(
                            "No history found for this routine",
                            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                          )
                        else ...[
                          Text("Fetched History :"),
                          Text(
                            DateFormat("dd MMM yyyy").format(lastHistory.createdAt),
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            "Change",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ],
                    ),
                    Divider(height: 35),
                    Expanded(
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        itemBuilder: (_, i) => RecordWorkoutPageViewItem(
                          exercise: routine.exercises[i],
                          index: i,
                          lastWorkoutChild: lastHistory?.logs.firstWhereOrNull(
                            (e) => e.exerciseId == routine.exercises[i].id,
                          ),
                        ),
                        itemCount: routine.exercises.length,
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
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void onCompleteTap() {
    if (!rwCubit.hasNonEmptySets()) {
      showErrorSnackBar(context, "Add at least one exercise's sets");
    } else if (rwCubit.hasEmptySets()) {
      context.dialog(
        ConfirmationDialog(
          message:
              "Your workout contains one or more exercise(s) with no sets recorded, "
              "Please note that these exercises will be removed from this workout and won't be shown in history."
              "\n\nProceed anyway?",
          onConfirmed: () {
            context.pop();
            showAddNoteDialog();
          },
        ),
      );
    } else {
      showAddNoteDialog();
    }
  }

  void showAddNoteDialog() {
    context.dialog(
      DialogAddWorkoutNote(
        onSavePressed: (String? note) {
          rwCubit.completeWorkout(note);
        },
      ),
    );
  }

  void changePage({required bool toNext}) {
    late final int index;
    if (toNext) {
      index = pageController.page!.round() + 1;
    } else {
      index = pageController.page!.round() - 1;
    }

    rwCubit.changeExercise(routine.exercises[index].id);
    setState(() => currentExerciseIndex = index);

    final duration = const Duration(milliseconds: 400);
    final curve = Curves.linearToEaseOut;
    pageController.animateToPage(
      index,
      curve: curve,
      duration: duration,
    );
  }
}
