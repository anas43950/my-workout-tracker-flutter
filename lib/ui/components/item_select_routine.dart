import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

class ItemSelectRoutine extends StatelessWidget {
  final String name;
  final VoidCallback onSelectTap;
  final bool isSelected;
  final bool isToday;

  const ItemSelectRoutine({
    super.key,
    required this.name,
    required this.onSelectTap,
    required this.isSelected,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isToday ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: isToday ? Border.all(color: Colors.blue, width: 0.5) : null,
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
            ),
          ),
          if (!isSelected)
            ClickableText(
              text: "Select",
              onTap: onSelectTap,
            ),
        ],
      ),
    );
  }
}
