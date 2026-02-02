import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';
import 'package:workout_tracker/utils/constants.dart';

class ItemRoutine extends StatelessWidget {
  final int index;

  const ItemRoutine({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              weekdaysFull[index],
            ),
          ),
          if (index < 2)
            ClickableText(
              text: "Add",
              onTap: () {
                context.pushNamed(Routes.selectWorkoutsForRoutine);
              },
            )
          else ...[
            ClickableText(
              textColor: Colors.red,
              text: "Delete",
              onTap: () {},
            ),
            10.width,
            ClickableText(
              text: "View",
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }
}
