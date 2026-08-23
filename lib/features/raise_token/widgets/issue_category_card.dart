import 'package:flutter/material.dart';

class IssueCategory {
  final String title;
  final IconData icon;

  const IssueCategory({
    required this.title,
    required this.icon,
  });
}

class IssueCategoryCard extends StatelessWidget {
  final IssueCategory category;
  final bool selected;
  final VoidCallback onTap;

  const IssueCategoryCard({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 105,
          height: 95,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected
                ? Colors.pink.shade50
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? Colors.pink
                  : Colors.grey.shade300,
              width: selected ? 2.5 : 1,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: Colors.pink.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                size: 28,
                color: selected
                    ? Colors.pink
                    : Colors.grey.shade700,
              ),

              const SizedBox(height: 7),

              Text(
                category.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: selected
                      ? Colors.pink.shade700
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}