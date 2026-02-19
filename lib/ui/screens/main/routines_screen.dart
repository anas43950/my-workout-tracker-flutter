import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/data/cubits/routines/routines_list_cubit.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_routine.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/ui/dialogs/confirmation_dialog.dart';
import 'package:workout_tracker/ui/dialogs/dialog_select_routine.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutinesListCubit, RoutinesListState>(
      builder: (context, state) {
        return CustomScaffold(
          floatingActionButton: state is FetchRoutinesInProgress
              ? null
              : FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    if (state is FetchRoutinesSuccess) {
                      onStartWorkoutTap(context, state);
                    }
                  },
                  label: Row(
                    children: [
                      Text("Start Workout"),
                      5.width,
                      Icon(
                        FluentIcons.play_12_filled,
                        size: 20,
                      ),
                    ],
                  ),
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, ${SharedPrefUtils.getString(AppStrings.userFullName)} 👋",
                    style: AppTextStyles.heading,
                  ),
                  IconButton(
                    onPressed: () {
                      context.dialog(
                        ConfirmationDialog(
                          title: "Logout",
                          message: "Are you sure you want to logout?",
                          onConfirmed: () {
                            context.read<AuthenticationCubit>().logout();
                          },
                        ),
                      );
                    },
                    icon: Icon(FluentIcons.sign_out_24_regular),
                  ),
                ],
              ),
              10.height,
              Text(
                "Add a workout routine for each week day",
                style: AppTextStyles.bodySmall,
              ),
              20.height,
              Expanded(
                child: state is FetchRoutinesInProgress
                    ? Center(child: CustomLoader(color: black))
                    : state is FetchRoutinesFail
                    ? Center(child: Text(state.message))
                    : state is FetchRoutinesSuccess
                    ? ListView.separated(
                        itemBuilder: (_, i) {
                          final name = weekdays[i];
                          final routine = state.routines.firstWhereOrNull((element) => element.name == name);
                          return ItemRoutine(
                            name: name,
                            routine: routine,
                          );
                        },
                        separatorBuilder: (_, i) => Divider(
                          height: 25,
                          thickness: 0.1,
                        ),
                        itemCount: weekdays.length,
                      )
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }

  void onStartWorkoutTap(BuildContext context, FetchRoutinesSuccess state) {
    if (state.routines.isEmpty) {
      showErrorSnackBar(context, "Add at least one routine to start workout");
      return;
    }
    final routine = context.read<RoutinesListCubit>().getRoutineForName(todayWeekDay);
    context.dialog(DialogSelectRoutine(selectedRoutine: routine));
  }
}
