import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide black, white;
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkoutRecordEntry extends StatelessWidget {
  final int index;
  final Workout workout;

  const ItemWorkoutRecordEntry({
    super.key,
    required this.workout,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${index + 1} - ${workout.name}",
                style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                workout.setsData,
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
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last log",
                            style: AppTextStyles.label,
                          ),
                          Column(
                            children: [
                              Text(
                                "Wed, 28 Jan",
                                style: AppTextStyles.bodySmall.copyWith(decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ],
                      ),
                      5.height,
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Text(
                        "Today's progress",
                        style: AppTextStyles.label,
                      ),
                      5.height,
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                      Text("50 kgs - 10 reps"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 40),
          Text(
            "New set entry",
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          15.height,
          Row(
            spacing: 15,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Weight"),
                  // validator: (email) => Validators.emailValidator(email),
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Reps"),
                  // validator: (email) => Validators.emailValidator(email),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {},
                backgroundColor: Colors.blueAccent,
                child: Icon(FluentIcons.add_12_filled),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
