import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart' hide ContextExtensions;
import 'package:workout_tracker/data/cubits/routines/routines_list_cubit.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/item_select_routine.dart';
import 'package:workout_tracker/ui/components/small_button.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';

class DialogSelectRoutine extends StatefulWidget {
  final Routine? selectedRoutine;

  const DialogSelectRoutine({
    super.key,
    this.selectedRoutine,
  });

  @override
  State<DialogSelectRoutine> createState() => _DialogSelectRoutineState();
}

class _DialogSelectRoutineState extends State<DialogSelectRoutine> {
  Routine? selectedRoutine;

  @override
  void initState() {
    super.initState();
    selectedRoutine = widget.selectedRoutine;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocBuilder<RoutinesListCubit, RoutinesListState>(
        builder: (context, state) {
          if (state is FetchRoutinesSuccess) {
            final routines = state.routines;
            routines.sort((r1, r2) => wdPos[r1.name]!.compareTo(wdPos[r2.name]!));
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  selectedRoutine == null
                      ? Text(
                          "No routine found for today i.e. $todayWeekDay\nselect a routine to continue",
                          style: TextStyle(color: Colors.grey.shade700),
                          textAlign: TextAlign.center,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Selected: ",
                              style: AppTextStyles.label.copyWith(color: grey),
                            ),
                            Text(
                              selectedRoutine?.name ?? "",
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                  15.height,
                  ...routines.expand(
                    (e) => [
                      ItemSelectRoutine(
                        name: e.name,
                        onSelectTap: () => setState(() => selectedRoutine = e),
                        isSelected: selectedRoutine == e,
                        isToday: e == selectedRoutine,
                      ),
                      10.height,
                    ],
                  ),
                  if (selectedRoutine != null)
                    SmallButton(
                      title: "Confirm",
                      onPressed: () {
                        if (selectedRoutine == null) return;
                        context.pop();
                        context.pushNamed(
                          Routes.recordWorkout,
                          extra: {
                            'routine': selectedRoutine,
                          },
                        );
                      },
                    ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
