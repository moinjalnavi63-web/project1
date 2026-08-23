import 'package:flutter/material.dart';

import '../models/token_model.dart';

class StatusBadge extends StatelessWidget {
  final TokenStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  Color get backgroundColor {
    switch (status) {
      case TokenStatus.open:
        return Colors.red.shade50;

      case TokenStatus.reviewing:
        return Colors.amber.shade50;

      case TokenStatus.resolved:
        return Colors.green.shade50;
    }
  }

  Color get textColor {
    switch (status) {
      case TokenStatus.open:
        return Colors.red.shade700;

      case TokenStatus.reviewing:
        return Colors.orange.shade800;

      case TokenStatus.resolved:
        return Colors.green.shade700;
    }
  }

  IconData get icon {
    switch (status) {
      case TokenStatus.open:
        return Icons.error_outline;

      case TokenStatus.reviewing:
        return Icons.hourglass_top;

      case TokenStatus.resolved:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: textColor.withOpacity(0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: textColor,
          ),
          const SizedBox(width: 5),
          Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String get statusText {
    switch (status) {
      case TokenStatus.open:
        return "Open";

      case TokenStatus.reviewing:
        return "Reviewing";

      case TokenStatus.resolved:
        return "Resolved";
    }
  }
}