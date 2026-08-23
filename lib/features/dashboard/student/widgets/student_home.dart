import 'package:flutter/material.dart';

import 'welcome_card.dart';
import 'announcement_card.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [


          const Text(
            "Announcements",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const AnnouncementCard(
            title: "Bus Delay",
            message: "Bus No.1 will arrive 10 minutes late due to traffic.",
            date: "Today",
          ),

          const AnnouncementCard(
            title: "Holiday Notice",
            message: "University transport will remain closed tomorrow.",
            date: "Yesterday",
          ),

          const AnnouncementCard(
            title: "Emergency",
            message:
            "Heavy rainfall expected. Please reach your stop 10 minutes early.",
            date: "2 days ago",
          ),
        ],
      ),
    );
  }
}