import 'package:flutter/material.dart';

class AdminTokenCard extends StatelessWidget {
  final String tokenId;
  final String studentName;
  final String usn;
  final String issueCategory;
  final String description;
  final String status;
  final String busNumber;
  final String date;
  final String time;
  final VoidCallback onTap;

  const AdminTokenCard({
    super.key,
    required this.tokenId,
    required this.studentName,
    required this.usn,
    required this.issueCategory,
    required this.description,
    required this.status,
    required this.busNumber,
    required this.date,
    required this.time,
    required this.onTap,
  });

  Color get statusColor {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Resolved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get categoryColor {
    switch (issueCategory) {
      case 'Bus':
        return Colors.deepPurple;
      case 'Seat':
        return Colors.indigo;
      case 'Driver':
        return Colors.teal;
      case 'Route':
        return Colors.cyan;
      case 'Attendance':
        return Colors.orange;
      case 'Safety':
        return Colors.red;
      case 'Other':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                    categoryColor.withValues(alpha: 0.12),
                    child: Icon(
                      Icons.confirmation_number_outlined,
                      color: categoryColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tokenId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          '$studentName • $usn',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      issueCategory,
                      style: TextStyle(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    busNumber,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.chevron_right,
                    size: 22,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                '$date • $time',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}