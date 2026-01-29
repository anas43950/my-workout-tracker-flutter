import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/components/custom_app_bar.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/item_workout_record_entry.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';

class RecordWorkoutScreen extends StatefulWidget {
  const RecordWorkoutScreen({super.key});

  @override
  State<RecordWorkoutScreen> createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final pageController = PageController();

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
              "Sunday",
              style: AppTextStyles.bodyMedium,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "Change",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          30.height,
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (_, i) => ItemWorkoutRecordEntry(),
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
