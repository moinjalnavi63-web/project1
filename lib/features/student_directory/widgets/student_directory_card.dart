import 'package:flutter/material.dart';

import '../models/student_directory_model.dart';

class StudentDirectoryCard extends StatelessWidget {
  final StudentDirectoryModel student;

  // Student:
  // showProfilePhoto = false
  //
  // Admin/Driver:
  // showProfilePhoto = true
  final bool showProfilePhoto;

  const StudentDirectoryCard({
    super.key,
    required this.student,
    this.showProfilePhoto = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(17),

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

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          // =====================================================
          // PROFILE PHOTO
          // =====================================================

          if (showProfilePhoto) ...[
            _buildProfilePhoto(),

            const SizedBox(width: 12),
          ],

          // =====================================================
          // STUDENT INFORMATION
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // NAME
                Text(
                  student.name,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // USN
                Text(
                  student.usn,

                  style: const TextStyle(
                    color: Color(0xFF5B5FEF),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                // YEAR
                Row(
                  children: [
                    const Icon(
                      Icons.school_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),

                    const SizedBox(width: 4),

                    Text(
                      student.year,

                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 11,
                      ),
                    ),

                    // BRANCH
                    if (showProfilePhoto) ...[
                      const SizedBox(width: 8),

                      Container(
                        width: 4,
                        height: 4,

                        decoration: const BoxDecoration(
                          color: Color(0xFF9CA3AF),
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        student.branch,

                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // =====================================================
          // STOP ICON FOR ADMIN / DRIVER
          // =====================================================

          if (showProfilePhoto)
            Container(
              padding: const EdgeInsets.all(7),

              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),

                borderRadius: BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF7C3AED),
                size: 18,
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE PHOTO
  // ==========================================================

  Widget _buildProfilePhoto() {
    final photo = student.profilePhoto;

    // No photo available
    if (photo == null || photo.trim().isEmpty) {
      return const CircleAvatar(
        radius: 27,

        backgroundColor: Color(0xFFEDE9FE),

        child: Icon(
          Icons.person,
          color: Color(0xFF5B5FEF),
          size: 28,
        ),
      );
    }

    // Asset image
    return CircleAvatar(
      radius: 27,

      backgroundColor: const Color(0xFFEDE9FE),

      backgroundImage: AssetImage(photo),
    );
  }
}