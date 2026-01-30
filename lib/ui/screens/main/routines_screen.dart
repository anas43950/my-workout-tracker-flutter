import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_routine.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(Routes.recordWorkout);
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
                "Hello, Anas 👋",
                style: AppTextStyles.heading,
              ),
              IconButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().logout();
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
            child: ListView.separated(
              itemBuilder: (_, i) => ItemRoutine(index: i),
              separatorBuilder: (_, i) => Divider(
                height: 25,
                thickness: 0.1,
              ),
              itemCount: weekdaysFull.length,
            ),
          ),
        ],
      ),
    );
  }
}
