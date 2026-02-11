import 'package:flutter/material.dart';
import 'package:workout_tracker/ui/components/clickable_text.dart';

class ItemSelectRoutine extends StatelessWidget {
  final String name;
  final VoidCallback onSelectTap;
  final bool isSelected;

  const ItemSelectRoutine({
    super.key,
    required this.name,
    required this.onSelectTap,
    required this.isSelected,
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
              name,
            ),
          ),
          ClickableText(
            text: isSelected ? "Selected" : "Select",
            onTap: onSelectTap,
            textColor: isSelected ? Colors.grey : null,
          ),
        ],
      ),
    );
  }
}
