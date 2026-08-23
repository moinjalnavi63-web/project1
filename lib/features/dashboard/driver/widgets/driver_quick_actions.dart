import 'package:flutter/material.dart';

class DriverQuickActions extends StatelessWidget {
  const DriverQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.05,
      children: const [

        DriverActionCard(
          title: "Driver Profile",
          icon: Icons.person,
          color: Color(0xFF5B5FEF),
        ),

        DriverActionCard(
          title: "Assigned Bus",
          icon: Icons.directions_bus,
          color: Color(0xFF0EA5E9),
        ),

        DriverActionCard(
          title: "Assigned Route",
          icon: Icons.route,
          color: Color(0xFF10B981),
        ),

        DriverActionCard(
          title: "Bus Student Group",
          icon: Icons.groups,
          color: Color(0xFFF59E0B),
        ),

        DriverActionCard(
          title: "Live GPS",
          icon: Icons.location_on,
          color: Color(0xFFEF4444),
        ),

        DriverActionCard(
          title: "Trip Status",
          icon: Icons.alt_route,
          color: Color(0xFF8B5CF6),
        ),

        DriverActionCard(
          title: "Announcements",
          icon: Icons.campaign,
          color: Color(0xFF14B8A6),
        ),

        DriverActionCard(
          title: "Today's Students",
          icon: Icons.people,
          color: Color(0xFFE11D48),
        ),
      ],
    );
  }
}

class DriverActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DriverActionCard({
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
            content: Text("$title feature coming soon"),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.92),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
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
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                size: 30,
                color: color,
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