import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/data/cubits/workouts/record_workout_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/data/models/workout_set.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class RecordWorkoutPageViewItem extends StatefulWidget {
  final int index;
  final Exercise exercise;
  final WorkoutChild? lastWorkoutChild; // Last workout history for this exercise

  const RecordWorkoutPageViewItem({
    super.key,
    required this.exercise,
    required this.index,
    this.lastWorkoutChild,
  });

  @override
  State<RecordWorkoutPageViewItem> createState() => _RecordWorkoutPageViewItemState();
}

class _RecordWorkoutPageViewItemState extends State<RecordWorkoutPageViewItem> {
  final FocusNode weightFocusNode = FocusNode();

  final weightTextController = TextEditingController();
  final repsTextController = TextEditingController();
  final dWeightTextController = TextEditingController();
  final dRepsTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final weightRegex = RegExp(r'^\d+\.?\d{0,3}');
  final repsRegex = RegExp(r'^\d*$');
  bool showDropSetFields = false;

  String? repsValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "Required";
    }
    if (!repsRegex.hasMatch(value!)) {
      return "Invalid reps";
    }

    return null;
  }

  String? weightValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "Required";
    }
    if (!weightRegex.hasMatch(value!)) {
      return "Invalid weight";
    }
    return null;
  }

  String? dWeightValidator(String? value) {
    if (showDropSetFields) {
      if (value?.trim().isEmpty == true) {
        return "Required";
      }
      if (!weightRegex.hasMatch(value!)) {
        return "Invalid weight";
      }
    }
    return null;
  }

  String? dRepsValidator(String? value) {
    if (showDropSetFields) {
      if (value?.trim().isEmpty == true) {
        return "Required";
      }
      if (!repsRegex.hasMatch(value!)) {
        return "Invalid reps";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordWorkoutCubit, RecordWorkoutState>(
      buildWhen: (context, state) {
        return state is RecordWorkoutInProgress && state.currentExerciseId == widget.exercise.id;
      },
      builder: (context, state) {
        if (state is RecordWorkoutInProgress) {
          final setsProgress = state.setsData[widget.exercise.id] ?? [];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade100,
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 15,
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.index + 1} - ${widget.exercise.name}",
                            style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                          widget.exercise.setsData,
                          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  15.height,
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 5,
                            children: [
                              Text(
                                "Last log",
                                style: AppTextStyles.label,
                              ),
                              3.height,
                              if (widget.lastWorkoutChild == null)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Not Found",
                                      style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                )
                              else
                                ...widget.lastWorkoutChild!.sets.mapIndexed(
                                  (i, e) => _ItemWorkoutSet(
                                    index: i,
                                    set: e,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Column(
                            spacing: 5,
                            children: [
                              Text(
                                "Today's progress",
                                style: AppTextStyles.label,
                              ),
                              5.height,
                              if (setsProgress.isEmpty)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "No progress yet",
                                      style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                )
                              else
                                ...setsProgress.mapIndexed(
                                  (i, e) => _ItemWorkoutSet(
                                    index: i,
                                    showRemoveButton: i == setsProgress.length - 1,
                                    set: e,
                                    onRemoveTap: () => context.read<RecordWorkoutCubit>().removeLastSet(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 15,
                    children: [
                      Expanded(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Main working set",
                                    style: AppTextStyles.bodyMedium,
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() => showDropSetFields = !showDropSetFields);
                                    },
                                    child: Text(
                                      "${!showDropSetFields ? "Add" : "Remove"} Drop Set",
                                      style: AppTextStyles.bodySmall.copyWith(
                                        decoration: TextDecoration.underline,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                spacing: 15,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      focusNode: weightFocusNode,
                                      hintText: "Wt. (Kgs)",
                                      controller: weightTextController,
                                      validator: weightValidator,
                                      allowDigitsOnly: true,
                                      padding: EdgeInsets.symmetric(horizontal: 7),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: "Reps",
                                      controller: repsTextController,
                                      validator: repsValidator,
                                      allowDigitsOnly: true,
                                      padding: EdgeInsets.symmetric(horizontal: 7),
                                    ),
                                  ),
                                ],
                              ),
                              if (showDropSetFields) ...[
                                20.height,
                                Text(
                                  "Drop set (Optional)",
                                  style: AppTextStyles.bodyMedium,
                                ),
                                10.height,
                                Row(
                                  spacing: 15,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: "Wt. (Kgs)",
                                        validator: dWeightValidator,
                                        controller: dWeightTextController,
                                        allowDigitsOnly: true,
                                        padding: EdgeInsets.symmetric(horizontal: 7),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: "Reps",
                                        validator: dRepsValidator,
                                        controller: dRepsTextController,
                                        allowDigitsOnly: true,
                                        changeToDoneKey: true,
                                        padding: EdgeInsets.symmetric(horizontal: 7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onEnterTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          textStyle: TextStyle(fontSize: 14),
                        ),
                        child: Text("Enter"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  void onEnterTap() {
    if (formKey.currentState!.validate()) {
      final weight = double.parse(weightTextController.text);
      final reps = int.parse(repsTextController.text);

      final dWeight = double.tryParse(dWeightTextController.text);
      final dReps = int.tryParse(dRepsTextController.text);

      final set = WorkoutSet(
        reps: reps,
        weight: weight,
        dropSetReps: dReps,
        dropSetWeight: dWeight,
      );

      context.read<RecordWorkoutCubit>().addSet(set);

      weightTextController.clear();
      repsTextController.clear();
      dRepsTextController.clear();
      dWeightTextController.clear();

      weightFocusNode.requestFocus();
      setState(() => showDropSetFields = false);
    }
  }
}

class _ItemWorkoutSet extends StatelessWidget {
  final int index;
  final bool? showRemoveButton;
  final WorkoutSet set;
  final VoidCallback? onRemoveTap;

  const _ItemWorkoutSet({
    required this.index,
    this.showRemoveButton,
    required this.set,
    this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            "${index + 1} -  ",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(set.repsData),
                if (set.hasDropSet)
                  Text(
                    set.dropSetRepsData,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                  ),
              ],
            ),
          ),
          if (showRemoveButton == true) ...[
            5.width,
            GestureDetector(
              onTap: onRemoveTap,
              child: Icon(
                FluentIcons.subtract_square_16_filled,
                color: Colors.redAccent,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
