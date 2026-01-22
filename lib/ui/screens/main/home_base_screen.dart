import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/ui/screens/main/past_records_screen.dart';
import 'package:workout_tracker/ui/screens/main/routines_screen.dart';
import 'package:workout_tracker/ui/screens/main/workouts_screen.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar((index) => setState(() => selectedIndex = index), selectedIndex),
      body: [
        PastRecordsScreen(),
        RoutinesScreen(),
        WorkoutsScreen(),
      ][selectedIndex],
    );
  }
}

Widget _buildBottomNavigationBar(Function(int index) onTabChanged, int selectedIndex) {
  return GNav(
    onTabChange: onTabChanged,
    padding: EdgeInsetsGeometry.all(10),
    backgroundColor: Colors.white,
    tabBackgroundColor: lightBlue,
    tabMargin: EdgeInsetsGeometry.all(10),
    gap: 10,
    tabs: [
      GButton(
        icon: selectedIndex == 0 ? FluentIcons.history_16_filled : FluentIcons.history_16_regular,
        text: "Past Records",
      ),
      GButton(
        icon: selectedIndex == 1 ? FluentIcons.calendar_16_filled : FluentIcons.calendar_16_regular,
        text: "Routine",
      ),
      GButton(
        icon: selectedIndex == 2 ? FluentIcons.dumbbell_16_filled : FluentIcons.dumbbell_16_regular,
        text: "Workouts",
      ),
    ],
  );
}
