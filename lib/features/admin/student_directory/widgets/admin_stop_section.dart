import 'package:flutter/material.dart';

import '../data/demo_student_directory.dart';
import 'admin_directory_student_card.dart';

class AdminStopSection extends StatelessWidget {
  final DirectoryStop stop;

  const AdminStopSection({
    super.key,
    required this.stop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xffede9fe),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xff7c3aed),
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  stop.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff3f4f6),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  '${stop.students.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          if (stop.students.isEmpty)
            Padding(
              padding:
              const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Center(
                child: Text(
                  'No students registered at this stop',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ),
            )
          else
            ...stop.students.map(
                  (student) => AdminDirectoryStudentCard(
                student: student,
              ),
            ),
        ],
      ),
    );
  }
}