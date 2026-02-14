import 'package:flutter/cupertino.dart';
import 'package:workout_tracker/ui/theme/colors.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;

  const CustomLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: color ?? white);
  }
}
