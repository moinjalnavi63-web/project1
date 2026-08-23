import 'package:flutter/material.dart';

import '../../../profile/student/pages/student_profile_screen.dart';
class StudentQuickActions extends StatelessWidget {
  const StudentQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.05,
      children: [

        QuickActionCard(
          title: "Profile",
          icon: Icons.person,
          color: const Color(0xFF5B5FEF),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StudentProfileScreen(),
              ),
            );
          },
        ),

        const QuickActionCard(
          title: "Bus Directory",
          icon: Icons.directions_bus,
          color: Color(0xFF0EA5E9),
        ),

        const QuickActionCard(
          title: "Seat Allocator",
          icon: Icons.event_seat,
          color: Color(0xFF10B981),
        ),

        const QuickActionCard(
          title: "Bus Group",
          icon: Icons.groups,
          color: Color(0xFFF59E0B),
        ),

        const QuickActionCard(
          title: "GPS Tracking",
          icon: Icons.location_on,
          color: Color(0xFFEF4444),
        ),

        const QuickActionCard(
          title: "Raise Token",
          icon: Icons.confirmation_number,
          color: Color(0xFF8B5CF6),
        ),

        const QuickActionCard(
          title: "Announcements",
          icon: Icons.campaign,
          color: Color(0xFF14B8A6),
        ),

        const QuickActionCard(
          title: "Student Directory",
          icon: Icons.people,
          color: Color(0xFFE11D48),
        ),
      ],
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap ??
              () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$title will be implemented next"),
                duration: const Duration(seconds: 1),
              ),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}