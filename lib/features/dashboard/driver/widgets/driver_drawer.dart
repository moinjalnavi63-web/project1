import 'package:flutter/material.dart';

import '../pages/driver_dashboard_screen.dart';
import 'driver_assigned_bus_screen.dart';
import 'driver_assigned_route_screen.dart';
import '../pages/driver_profile_screen.dart';

// Login Screen
import '../../../authentication/presentation/pages/login_screen.dart';

class DriverDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const DriverDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5B5FEF),
                    Color(0xFF7C83FD),
                  ],
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF5B5FEF),
                      size: 40,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Driver Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Driver ID : DR001",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DriverDrawerTile(
                    title: "Dashboard",
                    icon: Icons.dashboard_outlined,
                    selected: selectedIndex == 0,
                    onTap: () {
                      onItemSelected(0);
                    },
                  ),

                  DriverDrawerTile(
                    title: "Driver Profile",
                    icon: Icons.person_outline,
                    selected: selectedIndex == 1,
                    onTap: () {
                      onItemSelected(1);
                    },
                  ),

                  DriverDrawerTile(
                    title: "Assigned Bus",
                    icon: Icons.directions_bus_outlined,
                    selected: selectedIndex == 2,
                    onTap: () {
                      onItemSelected(2);
                    },
                  ),

                  DriverDrawerTile(
                    title: "Assigned Route",
                    icon: Icons.route_outlined,
                    selected: selectedIndex == 3,
                    onTap: () {
                      onItemSelected(3);
                    },
                  ),

                  DriverDrawerTile(
                    title: "Bus Student Group",
                    icon: Icons.groups_outlined,
                    selected: selectedIndex == 4,
                    onTap: () {
                      onItemSelected(4);
                    },
                  ),

                  DriverDrawerTile(
                    title: "Live GPS Sharing",
                    icon: Icons.location_on_outlined,
                    selected: selectedIndex == 5,
                    onTap: () {
                      onItemSelected(5);
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            // =====================================================
            // LOGOUT
            // =====================================================

            DriverDrawerTile(
              title: "Logout",
              icon: Icons.logout,
              selected: false,
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class DriverDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const DriverDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF5B5FEF)
            .withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF5B5FEF),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight:
            selected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }
}