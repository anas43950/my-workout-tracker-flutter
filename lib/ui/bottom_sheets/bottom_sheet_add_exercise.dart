import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/exercises/manage_exercise_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/ui/components/text_field_with_label.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/validators.dart';

class BottomSheetAddExercise extends StatefulWidget {
  final Exercise? exercise;

  const BottomSheetAddExercise({super.key, this.exercise});

  @override
  State<BottomSheetAddExercise> createState() => _BottomSheetAddExerciseState();
}

class _BottomSheetAddExerciseState extends State<BottomSheetAddExercise> {
  final RANGE = "Range";
  final FIXED = "Fixed";
  late String repsType = RANGE;
  final nameController = TextEditingController();
  final setsController = TextEditingController();
  final repsFromController = TextEditingController();
  final repsToController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late final Exercise? exerciseForEdit;
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    exerciseForEdit = widget.exercise;
    isEditing = exerciseForEdit != null;

    if (isEditing) {
      nameController.text = exerciseForEdit!.name;
      setsController.text = exerciseForEdit!.sets.toString();
      repsFromController.text = exerciseForEdit!.repRangeFrom.toString();
      repsToController.text = exerciseForEdit!.repRangeTo.toString();

      repsType = exerciseForEdit!.hasFixedReps ? FIXED : RANGE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEditing ? "Update Exercise" : "Add Exercise",
                  style: AppTextStyles.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Divider(),
                20.height,
                TextFieldWithLabel(
                  label: 'Name',
                  hintText: 'Enter exercise name...',
                  controller: nameController,
                  validator: (value) => Validators.emptyValidator(value, "Enter name for this exercise"),
                ),
                15.height,
                TextFieldWithLabel(
                  label: 'Sets',
                  hintText: 'Enter number of sets...',
                  controller: setsController,
                  allowDigitsOnly: true,
                  validator: (value) => Validators.emptyValidator(value, "Enter the number of sets"),
                ),
                15.height,
                Text(
                  "Reps",
                  style: AppTextStyles.bodyMedium,
                ),
                RadioGroup(
                  onChanged: (val) {
                    if (val == null) return;
                    setState(() => repsType = val);
                    repsFromController.clear();
                    repsToController.clear();
                  },
                  groupValue: repsType,
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: RANGE,
                            title: Text(RANGE),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: FIXED,
                            title: Text(FIXED),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (repsType == FIXED)
                  CustomTextField(
                    hintText: "Enter number of reps...",
                    controller: repsFromController,
                    allowDigitsOnly: true,
                    validator: (value) => Validators.emptyValidator(value, "Enter the number of reps for each set"),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "From...",
                          controller: repsFromController,
                          allowDigitsOnly: true,
                          validator: (value) => Validators.emptyValidator(value, "'From' can't be empty"),
                        ),
                      ),
                      15.width,
                      Expanded(
                        child: CustomTextField(
                          hintText: "To...",
                          allowDigitsOnly: true,
                          controller: repsToController,
                          validator: (value) => Validators.emptyValidator(value, "'To' can't be empty"),
                        ),
                      ),
                    ],
                  ),
                25.height,
                BlocConsumer<ManageExerciseCubit, ManageExerciseState>(
                  listener: (context, state) {
                    if (state is AddExerciseSuccess) {
                      showSuccessSnackBar(context, "Exercise added");
                      nameController.clear();
                      setsController.clear();
                      repsFromController.clear();
                      repsToController.clear();
                    }
                    if (state is AddExerciseFail) {
                      showErrorSnackBar(context, state.message);
                    }
                    if (state is UpdateExerciseSuccess) {
                      showSuccessSnackBar(context, "Exercises updated");
                      context.pop();
                    }
                    if (state is UpdateExerciseFail) {
                      showErrorSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is AddExerciseInProgress) return;
                        onAddExerciseTap();
                      },
                      child: state is AddExerciseInProgress || state is UpdateExerciseInProgress
                          ? CustomLoader()
                          : Text(isEditing ? "Update" : "Add"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAddExerciseTap() {
    if (formKey.currentState?.validate() == true) {
      final name = nameController.text;
      final setsStr = setsController.text;
      final repRangeFromStr = repsFromController.text;
      final repRangeToStr = repsToController.text;

      final sets = int.parse(setsStr);
      final repRangeFrom = int.parse(repRangeFromStr);
      final repRangeTo = int.parse(
        repsType == FIXED ? repRangeFromStr : repRangeToStr,
      ); // In case of fixed, from and to are going to be same

      if (repRangeFrom > repRangeTo) {
        showErrorSnackBar(context, "'From' should be less than 'To'");
        return;
      }
      if (isEditing) {
        context.read<ManageExerciseCubit>().updateExercise(
          id: exerciseForEdit!.id,
          name: name,
          sets: sets,
          repRangeFrom: repRangeFrom,
          repRangeTo: repRangeTo,
        );
      } else {
        context.read<ManageExerciseCubit>().addExercise(
          name: name,
          sets: sets,
          repRangeFrom: repRangeFrom,
          repRangeTo: repRangeTo,
        );
      }
    }
  }
}
