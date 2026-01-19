import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/screens/base_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Text("Home Screen"),
        ],
      ),
    );
  }
}
