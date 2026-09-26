import 'package:flutter/material.dart';

import 'welcome_card.dart';
import 'student_announcement_card.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD1FAE5),
            Color(0xFFE0E7FF),
            Color(0xFFCFFAFE),
          ],
        ),
      ),

      child: ListView(
        padding: const EdgeInsets.all(20),

        children: const [
          SizedBox(height: 5),

          Text(
            "Announcements",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "Latest announcements from KUTS administration",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          SizedBox(height: 15),

          // ==========================================
          // REAL ANNOUNCEMENTS
          // ==========================================

          StudentAnnouncementCard(),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}