import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/workout/manage_workout_cubit.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/ui/components/text_field_with_label.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/validators.dart';

class BottomSheetAddWorkout extends StatefulWidget {
  final Workout? workoutForEdit;

  const BottomSheetAddWorkout({super.key, this.workoutForEdit});

  @override
  State<BottomSheetAddWorkout> createState() => _BottomSheetAddWorkoutState();
}

class _BottomSheetAddWorkoutState extends State<BottomSheetAddWorkout> {
  final RANGE = "Range";
  final FIXED = "Fixed";
  late String repsType = RANGE;
  final nameController = TextEditingController();
  final setsController = TextEditingController();
  final repsFromController = TextEditingController();
  final repsToController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late final Workout? workoutForEdit;
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    workoutForEdit = widget.workoutForEdit;
    isEditing = workoutForEdit != null;

    if (isEditing) {
      nameController.text = workoutForEdit!.name;
      setsController.text = workoutForEdit!.sets.toString();
      repsFromController.text = workoutForEdit!.repRangeFrom.toString();
      repsToController.text = workoutForEdit!.repRangeTo.toString();

      repsType = workoutForEdit!.hasFixedReps ? FIXED : RANGE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEditing ? "Update Workout" : "Add Workout",
                style: AppTextStyles.labelMedium,
                textAlign: TextAlign.center,
              ),
              Divider(),
              20.height,
              TextFieldWithLabel(
                label: 'Name',
                hintText: 'Enter workout name...',
                controller: nameController,
                validator: (value) => Validators.emptyValidator(value, "Enter name for this workout"),
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
              BlocConsumer<ManageWorkoutCubit, ManageWorkoutState>(
                listener: (context, state) {
                  if (state is AddWorkoutSuccess) {
                    showSuccessSnackBar(context, "Workout added");
                    nameController.clear();
                    setsController.clear();
                    repsFromController.clear();
                    repsToController.clear();
                  }
                  if (state is AddWorkoutFail) {
                    showErrorSnackBar(context, state.message);
                  }
                  if (state is UpdateWorkoutSuccess) {
                    showSuccessSnackBar(context, "Workout updated");
                    context.pop();
                  }
                  if (state is UpdateWorkoutFail) {
                    showErrorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (state is AddWorkoutInProgress) return;
                      onAddWorkoutTap();
                    },
                    child: state is AddWorkoutInProgress || state is UpdateWorkoutInProgress
                        ? CustomLoader()
                        : Text(isEditing ? "Update" : "Add"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddWorkoutTap() {
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
        context.read<ManageWorkoutCubit>().updateWorkout(
          id: workoutForEdit!.id,
          name: name,
          sets: sets,
          repRangeFrom: repRangeFrom,
          repRangeTo: repRangeTo,
        );
      } else {
        context.read<ManageWorkoutCubit>().addWorkout(
          name: name,
          sets: sets,
          repRangeFrom: repRangeFrom,
          repRangeTo: repRangeTo,
        );
      }
    }
  }
}
