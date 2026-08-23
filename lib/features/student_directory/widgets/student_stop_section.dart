import 'package:flutter/material.dart';

import '../models/student_directory_model.dart';
import 'student_directory_card.dart';

class StudentStopSection extends StatefulWidget {
  final String stopName;
  final List<StudentDirectoryModel> students;

  const StudentStopSection({
    super.key,
    required this.stopName,
    required this.students,
  });

  @override
  State<StudentStopSection> createState() =>
      _StudentStopSectionState();
}

class _StudentStopSectionState
    extends State<StudentStopSection> {

  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),

      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          // =====================================================
          // STOP HEADER
          // =====================================================

          InkWell(
            borderRadius: BorderRadius.circular(18),

            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },

            child: Padding(
              padding: const EdgeInsets.all(14),

              child: Row(
                children: [
                  // LOCATION ICON
                  Container(
                    width: 42,
                    height: 42,

                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE9FE),

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xFF7C3AED),
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 11),

                  // STOP NAME
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          widget.stopName,

                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          "${widget.students.length} student${widget.students.length == 1 ? '' : 's'}",

                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // EXPAND ICON
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,

                    color: const Color(0xFF5B5FEF),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // STUDENT LIST
          // =====================================================

          if (expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                0,
                12,
                8,
              ),

              child: Column(
                children: widget.students
                    .map(
                      (student) => StudentDirectoryCard(
                    student: student,

                    // Admin/Driver only
                    showProfilePhoto: true,
                  ),
                )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}