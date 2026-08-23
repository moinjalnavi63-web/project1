import 'package:flutter/material.dart';

import '../models/token_model.dart';
import 'status_badge.dart';

class TokenCard extends StatelessWidget {
  final TokenModel token;
  final VoidCallback? onTap;

  const TokenCard({
    super.key,
    required this.token,
    this.onTap,
  });

  Color get priorityColor {
    switch (token.priority) {
      case TokenPriority.low:
        return Colors.green;

      case TokenPriority.medium:
        return Colors.orange;

      case TokenPriority.high:
        return Colors.red;
    }
  }

  IconData get priorityIcon {
    switch (token.priority) {
      case TokenPriority.low:
        return Icons.circle;

      case TokenPriority.medium:
        return Icons.circle;

      case TokenPriority.high:
        return Icons.circle;
    }
  }

  String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    int hour = dateTime.hour;
    final minute = dateTime.minute
        .toString()
        .padLeft(2, '0');

    final period = hour >= 12 ? "PM" : "AM";

    hour = hour % 12;

    if (hour == 0) {
      hour = 12;
    }

    return "$day/$month/$year, $hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              // ==========================================
              // TOP ROW
              // ==========================================

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // Token ID
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Token ID",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          token.tokenId,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status
                  StatusBadge(
                    status: token.status,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const Divider(
                height: 1,
              ),

              const SizedBox(height: 14),

              // ==========================================
              // ISSUE
              // ==========================================

              Row(
                children: [
                  Icon(
                    Icons.report_problem_outlined,
                    size: 20,
                    color: Colors.pink.shade600,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Issue:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Text(
                      token.issueCategory,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==========================================
              // BUS NUMBER
              // ==========================================

              Row(
                children: [
                  const Icon(
                    Icons.directions_bus_outlined,
                    size: 20,
                    color: Colors.indigo,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Bus:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Text(
                    token.busNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==========================================
              // PRIORITY
              // ==========================================

              Row(
                children: [
                  Icon(
                    priorityIcon,
                    size: 14,
                    color: priorityColor,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Priority:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Text(
                    token.priorityText,
                    style: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==========================================
              // DATE
              // ==========================================

              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 20,
                    color: Colors.teal,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Raised:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Text(
                      formatDateTime(token.createdAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ==========================================
              // VIEW DETAILS
              // ==========================================

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 18,
                  ),
                  label: const Text(
                    "View Details",
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor:
                    Colors.pink.shade600,
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