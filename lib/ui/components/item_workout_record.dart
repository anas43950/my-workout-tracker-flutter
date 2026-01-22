import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';

class ItemWorkoutRecord extends StatelessWidget {
  const ItemWorkoutRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = ["Flat Bench Press", "Inclined Dumbbell Press", "Pec Deck Fly"];
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wed, 21 Jan 2026  -  Chest + Triceps",
                  style: TextStyles.bodySmall,
                ),
                Text(
                  "W - R",
                  style: TextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 1,
            thickness: 0.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                itemBuilder: (_, i) => _ItemWorkoutRecordExercise(workoutName: workouts[i], index: i),
                separatorBuilder: (_, i) => Divider(thickness: 0.0, height: 1),
                itemCount: workouts.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemWorkoutRecordExercise extends StatefulWidget {
  final String workoutName;
  final int index;

  const _ItemWorkoutRecordExercise({required this.workoutName, required this.index});

  @override
  State<_ItemWorkoutRecordExercise> createState() => _ItemWorkoutRecordExerciseState();
}

class _ItemWorkoutRecordExerciseState extends State<_ItemWorkoutRecordExercise> {
  bool expanded = false;
  final duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => expanded = !expanded),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: duration,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Text(
              (widget.index + 1).toString(),
              style: TextStyles.bodySmall,
            ),
            10.width,
            Expanded(
              child: Text(
                widget.workoutName,
              ),
            ),
            AnimatedAlign(
              duration: duration,
              alignment: Alignment.centerRight,
              heightFactor: expanded ? 1 : 0,
              child: Column(
                children: List.generate(
                  3,
                  (i) => AnimatedDefaultTextStyle(
                    style: TextStyle(
                      color: expanded ? Colors.black : Colors.transparent,
                      fontSize: expanded ? 14 : 8,
                      height: 1.5,
                    ),
                    duration: duration,
                    child: Text("76 - 8"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
