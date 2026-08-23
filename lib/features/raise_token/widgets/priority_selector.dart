import 'package:flutter/material.dart';

import '../models/token_model.dart';

class PrioritySelector extends StatelessWidget {
  final TokenPriority? selectedPriority;
  final ValueChanged<TokenPriority> onChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PriorityButton(
            priority: TokenPriority.low,
            label: "Low",
            icon: Icons.circle,
            iconColor: Colors.green,
            selected: selectedPriority == TokenPriority.low,
            onTap: () => onChanged(TokenPriority.low),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: _PriorityButton(
            priority: TokenPriority.medium,
            label: "Medium",
            icon: Icons.circle,
            iconColor: Colors.amber,
            selected: selectedPriority == TokenPriority.medium,
            onTap: () => onChanged(TokenPriority.medium),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: _PriorityButton(
            priority: TokenPriority.high,
            label: "High",
            icon: Icons.circle,
            iconColor: Colors.red,
            selected: selectedPriority == TokenPriority.high,
            onTap: () => onChanged(TokenPriority.high),
          ),
        ),
      ],
    );
  }
}

class _PriorityButton extends StatelessWidget {
  final TokenPriority priority;
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool selected;
  final VoidCallback onTap;

  const _PriorityButton({
    required this.priority,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: selected
                ? iconColor.withOpacity(0.12)
                : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? iconColor
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: iconColor.withOpacity(0.20),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 13,
                color: iconColor,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? iconColor
                        : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}