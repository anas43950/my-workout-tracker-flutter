import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/cubits/workouts/manage_workout_cubit.dart';
import 'package:workout_tracker/data/cubits/workouts/record_workout_cubit.dart';
import 'package:workout_tracker/ui/components/custom_text_field.dart';
import 'package:workout_tracker/utils/extensions.dart';

class DialogAddWorkoutNote extends StatefulWidget {
  final Function(String?) onSavePressed;

  const DialogAddWorkoutNote({
    super.key,
    required this.onSavePressed,
  });

  @override
  State<DialogAddWorkoutNote> createState() => _DialogAddWorkoutNoteState();
}

class _DialogAddWorkoutNoteState extends State<DialogAddWorkoutNote> {
  final textController = TextEditingController();

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
              controller: textController,
            ),
            BlocBuilder<ManageWorkoutCubit, ManageWorkoutState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state is SaveWorkoutInProgress) return;
                    widget.onSavePressed(textController.text.textOrNull);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(state is SaveWorkoutInProgress ? "Saving..." : "Save Workout"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
