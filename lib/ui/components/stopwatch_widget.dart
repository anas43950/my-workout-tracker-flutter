import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/helpers.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Timer? timer;
  int secondsPassed = 0;
  bool showCurrentTime = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => secondsPassed = timer.tick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () {
            setState(() => showCurrentTime = !showCurrentTime);
          },
          child: Icon(
            FluentIcons.arrow_swap_16_filled,
            color: Colors.blue,
          ),
        ),
        Text(
          showCurrentTime
              ? DateFormat("HH${timeSeparator}mm${timeSeparator}ss").format(DateTime.now())
              : getTimeText(secondsPassed),
          style: AppTextStyles.heading.copyWith(fontSize: 30, height: 0),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }
}
