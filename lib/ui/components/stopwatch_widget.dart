import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/logger.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Timer? timer;
  int secondsPassed = 0;
  bool showCurrentTime = false;

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
          _getTimeText(secondsPassed),
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

  String _getTimeText(int seconds) {
    final _sep = " : ";
    if (showCurrentTime) {
      return DateFormat("HH${_sep}mm${_sep}ss").format(DateTime.now());
    } else {
      var duration = Duration(seconds: seconds);
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String sDuration =
          "${twoDigits(duration.inHours) + _sep}"
          "${twoDigits(duration.inMinutes.remainder(60)) + _sep}"
          "${twoDigits(duration.inSeconds.remainder(60))}";

      return sDuration;
    }
  }
}
