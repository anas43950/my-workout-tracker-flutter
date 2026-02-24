import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart' hide ContextExtensions;
import 'package:workout_tracker/data/cubits/routines/manage_routine_cubit.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';
import 'package:workout_tracker/ui/dialogs/confirmation_dialog.dart';
import 'package:workout_tracker/utils/extensions.dart';

class ItemRoutine extends StatelessWidget {
  final String name;
  final Routine? routine;
  final bool isToday;

  const ItemRoutine({
    super.key,
    required this.name,
    this.routine,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isToday ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: isToday ? Border.all(color: Colors.blue, width: 0.5) : null,
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
            ),
          ),
          if (routine == null)
            ClickableText(
              text: "Add",
              onTap: () {
                context.pushNamed(
                  Routes.selectRoutineExercises,
                  extra: {
                    'name': name,
                    'routineForEdit': routine,
                  },
                );
              },
            )
          else ...[
            ClickableText(
              textColor: Colors.red,
              text: "Delete",
              onTap: () {
                context.dialog(
                  ConfirmationDialog(
                    title: "Delete this routine?",
                    message: "This routine will be permanently deleted",
                    onConfirmed: () {
                      context.pop();
                      context.read<ManageRoutineCubit>().deleteRoutine(id: routine!.id);
                    },
                  ),
                );
              },
            ),
            10.width,
            ClickableText(
              text: "View",
              onTap: () {
                context.pushNamed(
                  Routes.viewRoutine,
                  extra: routine,
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
