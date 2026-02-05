import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemRearrangeWorkout extends StatelessWidget {
  final int index;
  final String name;
  final Widget trailing;

  const ItemRearrangeWorkout({
    super.key,
    required this.name,
    required this.index,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.grey),
          ),
          10.width,
          Expanded(
            child: Text(name),
          ),
          trailing
        ],
      ),
    );
  }
}
