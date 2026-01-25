import 'package:flutter/material.dart';

class ItemSelectWorkout extends StatelessWidget {
  final bool selected;
  final Function(bool value) onSelectionChanged;

  const ItemSelectWorkout({super.key, required this.selected, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Flat Bench Press",
            ),
          ),
          Checkbox(
            shape: CircleBorder(),
            value: selected,
            onChanged: (value) {
              if (value == null) return;
              onSelectionChanged(value);
            },
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
