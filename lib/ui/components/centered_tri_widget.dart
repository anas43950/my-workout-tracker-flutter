import 'package:flutter/material.dart';

class CenteredTriWidget extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? center;

  const CenteredTriWidget({super.key, this.leading, this.trailing, this.center});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            leading ?? SizedBox(),
            Spacer(),
            trailing ?? SizedBox(),
          ],
        ),
        center ?? SizedBox(),
      ],
    );
  }
}
