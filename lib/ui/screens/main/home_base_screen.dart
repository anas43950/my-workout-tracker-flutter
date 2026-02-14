import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/auth/authentication_cubit.dart';
import 'package:workout_tracker/data/cubits/routines/routines_list_cubit.dart';
import 'package:workout_tracker/data/cubits/exercises/exercises_list_cubit.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/screens/main/routines_screen.dart';
import 'package:workout_tracker/ui/screens/main/workouts_history_screen.dart';
import 'package:workout_tracker/ui/screens/main/exercises_screen.dart';
import 'package:workout_tracker/utils/extensions.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    context.read<ExercisesListCubit>().fetchExercises();
    context.read<RoutinesListCubit>().fetchRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar((index) => setState(() => selectedIndex = index), selectedIndex),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LoggedOut) {
            context.clearStackAndNavigate(Routes.login);
          }
        },
        child: [
          RoutinesScreen(),
          ExercisesScreen(),
          WorkoutsHistoryScreen(),
        ][selectedIndex],
      ),
    );
  }
}

Widget _buildBottomNavigationBar(Function(int index) onTabChanged, int selectedIndex) {
  return GNav(
    onTabChange: onTabChanged,
    selectedIndex: selectedIndex,
    padding: EdgeInsetsGeometry.all(10),
    backgroundColor: Colors.white,
    tabBackgroundColor: lightBlue,
    tabMargin: EdgeInsetsGeometry.all(10),
    gap: 10,
    tabs: [
      GButton(
        icon: selectedIndex == 0 ? FluentIcons.calendar_16_filled : FluentIcons.calendar_16_regular,
        text: "Routine",
      ),
      GButton(
        icon: selectedIndex == 2 ? FluentIcons.dumbbell_16_filled : FluentIcons.dumbbell_16_regular,
        text: "Exercises",
      ),
      GButton(
        icon: selectedIndex == 2 ? FluentIcons.history_16_filled : FluentIcons.history_16_regular,
        text: "Workouts History",
      ),
    ],
  );
}
