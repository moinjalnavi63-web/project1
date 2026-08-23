import 'package:flutter/material.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 18,
      crossAxisSpacing: 18,
      childAspectRatio: 1.05,
      children: const [

        FeatureCard(
          title: "Profile",
          icon: Icons.person_outline,
          color: Color(0xFF5B5FEF),
        ),

        FeatureCard(
          title: "Bus Directory",
          icon: Icons.directions_bus_outlined,
          color: Color(0xFF0EA5E9),
        ),

        FeatureCard(
          title: "Live Tracker",
          icon: Icons.location_on_outlined,
          color: Color(0xFF10B981),
        ),

        FeatureCard(
          title: "Seat Counter",
          icon: Icons.event_seat_outlined,
          color: Color(0xFFF59E0B),
        ),

        FeatureCard(
          title: "Raise Token",
          icon: Icons.confirmation_number_outlined,
          color: Color(0xFFEF4444),
        ),

        FeatureCard(
          title: "Notifications",
          icon: Icons.notifications_active_outlined,
          color: Color(0xFF8B5CF6),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$title feature will be added soon"),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
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
              backgroundColor: color.withOpacity(0.12),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}