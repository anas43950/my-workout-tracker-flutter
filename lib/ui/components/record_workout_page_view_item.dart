import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/data/cubits/workout_history/record_workout_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/data/models/workout_set.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/logger.dart';
import 'package:workout_tracker/utils/validators.dart';

class RecordWorkoutPageViewItem extends StatefulWidget {
  final int index;
  final Exercise exercise;
  final WorkoutChild? lastWorkoutChild;
  final String? lastWorkoutDate;

  // If workout date is null, it means there is no past workout for the selected routine's day
  // If last workout date is not null, and only last workout child is null, it means there is a past workout, but no child for the current exercise

  const RecordWorkoutPageViewItem({
    super.key,
    required this.exercise,
    required this.index,
    this.lastWorkoutChild,
    this.lastWorkoutDate,
  });

  @override
  State<RecordWorkoutPageViewItem> createState() => _RecordWorkoutPageViewItemState();
}

class _RecordWorkoutPageViewItemState extends State<RecordWorkoutPageViewItem> {
  final weightTextController = TextEditingController();
  final repsTextController = TextEditingController();
  final dWeightTextController = TextEditingController();
  final dRepsTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? dWeightValidator(String? value) {
    if (dRepsTextController.text.trim().isNotEmpty && value?.trim().isEmpty == true) {
      return "Required";
    }
    return null;
  }

  String? dRepsValidator(String? value) {
    if (dWeightTextController.text.trim().isNotEmpty && value?.trim().isEmpty == true) {
      return "Required";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordWorkoutCubit, RecordWorkoutState>(
      buildWhen: (context, state) {
        return state is RecordWorkoutInProgress && state.currentExerciseId == widget.exercise.id;
      },
      builder: (context, state) {
        if (state is RecordWorkoutInProgress) {
          logger.d("rebuilding ${widget.exercise.id}");
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.index + 1} - ${widget.exercise.name}",
                        style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        widget.exercise.setsData,
                        style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Divider(height: 35),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Last log",
                                    style: AppTextStyles.label,
                                  ),
                                  if (widget.lastWorkoutDate != null)
                                    Text(
                                      widget.lastWorkoutDate!,
                                      style: AppTextStyles.bodySmall.copyWith(decoration: TextDecoration.underline),
                                    ),
                                ],
                              ),
                              3.height,
                              if (widget.lastWorkoutChild != null)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      widget.lastWorkoutDate == null ? "No history found" : "Not Found",
                                      style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                )
                              else
                                ...List.generate(
                                  4,
                                  (i) => SizedBox(),
                                ),
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                "Today's progress",
                                style: AppTextStyles.label,
                              ),
                              5.height,
                              ...state.setsData[widget.exercise.id]!.mapIndexed(
                                    (i, e) => _ItemWorkoutSet(
                                      index: i,
                                      showRemoveButton: i == state.setsData[widget.exercise.id]!.length - 1,
                                      set: e,
                                      onRemoveTap: () => context.read<RecordWorkoutCubit>().removeLastSet(),
                                    ),
                                  ) ??
                                  [SizedBox()],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 40),
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                "Main working set",
                                style: AppTextStyles.label,
                                textAlign: TextAlign.center,
                              ),
                              10.height,
                              Row(
                                spacing: 15,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: "Weight (Kgs)",
                                      controller: weightTextController,
                                      validator: (value) => Validators.emptyValidator(value, "Required"),
                                      formatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: "Reps",
                                      controller: repsTextController,
                                      validator: (value) => Validators.emptyValidator(value, "Required"),
                                      allowDigitsOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                              30.height,
                              Text(
                                "Drop set (Optional)",
                                style: AppTextStyles.label,
                                textAlign: TextAlign.center,
                              ),
                              10.height,
                              Row(
                                spacing: 15,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: "Weight (Kgs)",
                                      validator: dWeightValidator,
                                      controller: dWeightTextController,
                                      formatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: "Reps",
                                      validator: dRepsValidator,
                                      controller: dRepsTextController,
                                      allowDigitsOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: onEnterTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text("Enter"),
                    ),
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
    }
  }
}

class _ItemWorkoutSet extends StatelessWidget {
  final int index;
  final bool showRemoveButton;
  final WorkoutSet set;
  final VoidCallback? onRemoveTap;

  const _ItemWorkoutSet({
    super.key,
    required this.index,
    required this.showRemoveButton,
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
          if (showRemoveButton) ...[
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
