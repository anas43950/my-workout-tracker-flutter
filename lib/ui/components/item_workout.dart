import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class ItemWorkout extends StatelessWidget {
  const ItemWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      "Flat Bench Press",
      "Inclined Dumbbell Press",
      "Declined Dumbbell Press",
      "Pec Deck Fly",
      "Low to High Cable Crossover",
      "High to Low Cable Crossover",
    ];
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
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  "W - R",
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                itemBuilder: (_, i) => _WorkoutChild(exerciseName: exercises[i], index: i),
                separatorBuilder: (_, i) => Divider(height: 0),
                itemCount: exercises.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkoutChild extends StatefulWidget {
  final String exerciseName;
  final int index;

  const _WorkoutChild({required this.exerciseName, required this.index});

  @override
  State<_WorkoutChild> createState() => _WorkoutChildState();
}

class _WorkoutChildState extends State<_WorkoutChild> {
  bool expanded = false;
  final duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => expanded = !expanded),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: duration,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            Text(
              (widget.index + 1).toString(),
              style: AppTextStyles.bodySmall,
            ),
            10.width,
            Expanded(
              child: Text(
                widget.exerciseName,
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
