import 'package:flutter/cupertino.dart';
import 'package:workout_tracker/ui/theme/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(color: white);
  }
}
