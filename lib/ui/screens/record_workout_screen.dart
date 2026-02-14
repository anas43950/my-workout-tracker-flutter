import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/models/routine.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/models/workout_child.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/record_workout_page_view_item.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class RecordWorkoutScreen extends StatefulWidget {
  final Routine routine;

  const RecordWorkoutScreen({super.key, required this.routine});

  @override
  State<RecordWorkoutScreen> createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final pageController = PageController();
  late Routine routine;
  late Workout? lastHistory;
  List<WorkoutChild> logs = [];

  @override
  void initState() {
    super.initState();

    routine = widget.routine;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        showBackBtn: true,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text(
              "Today's routine :",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              routine.name,
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          25.height,
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (_, i) => RecordWorkoutPageViewItem(
                exercise: routine.exercises[i],
                index: i,
              ),
              itemCount: routine.exercises.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linearToEaseOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: lightGrey,
                    ),
                    child: Text("Previous"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linearToEaseOut,
                      );
                    },
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
