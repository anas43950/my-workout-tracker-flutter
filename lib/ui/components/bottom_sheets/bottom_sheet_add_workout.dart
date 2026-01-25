import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/text_field_with_label.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class BottomSheetAddWorkout extends StatefulWidget {
  const BottomSheetAddWorkout({
    super.key,
  });

  @override
  State<BottomSheetAddWorkout> createState() => _BottomSheetAddWorkoutState();
}

class _BottomSheetAddWorkoutState extends State<BottomSheetAddWorkout> {
  final RANGE = "Range";
  final FIXED = "Fixed";
  late String repsType = FIXED;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Workout",
            style: AppTextStyles.labelMedium,
            textAlign: TextAlign.center,
          ),
          Divider(),
          20.height,
          TextFieldWithLabel(
            label: 'Name',
            hintText: 'Enter workout name...',
          ),
          15.height,
          TextFieldWithLabel(
            label: 'Sets',
            hintText: 'Enter number of sets...',
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
            },
            groupValue: repsType,
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: FIXED,
                      title: Text(FIXED),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: RANGE,
                      title: Text(RANGE),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (repsType == FIXED)
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter number of reps...",
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "From...",
                    ),
                  ),
                ),
                15.width,
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "To...",
                    ),
                  ),
                ),
              ],
            ),
          25.height,
          ElevatedButton(
            onPressed: () {},
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
