import 'package:flutter/material.dart';

class ItemSelectExercise extends StatelessWidget {
  final String name;
  final bool selected;
  final Function(bool value) onSelectionChanged;

  const ItemSelectExercise({super.key, required this.selected, required this.onSelectionChanged, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(name),
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
