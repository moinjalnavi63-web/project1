
import 'dart:io';

import 'package:flutter/material.dart';

import '../pages/driver_dashboard_screen.dart';
import '../pages/driver_profile_screen.dart';
import '../pages/driver_profile_data.dart';
import 'driver_assigned_bus_screen.dart';
import 'driver_assigned_route_screen.dart';
import '../../../authentication/presentation/pages/login_screen.dart';

class DriverDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const DriverDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const Color primaryColor = Color(0xFF5B5FEF);

  @override
  Widget build(BuildContext context) {
    final profile = DriverProfileData.instance;

    return AnimatedBuilder(
      animation: profile,
      builder: (context, child) {
        final photoPath = profile.photoPath;
        final hasPhoto = photoPath != null &&
            photoPath.isNotEmpty &&
            File(photoPath).existsSync();

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
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        backgroundImage: hasPhoto
                            ? FileImage(File(photoPath))
                            : null,
                        child: hasPhoto
                            ? null
                            : const Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.driverName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Driver ID: ${profile.driverId}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Bus: ${profile.busNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              profile.route,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
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
                        title: 'Driver Profile',
                        icon: Icons.person_outline,
                        selected: selectedIndex == 1,
                        onTap: () => onItemSelected(1),
                      ),
                      DriverDrawerTile(
                        title: 'Assigned Bus',
                        icon: Icons.directions_bus_outlined,
                        selected: selectedIndex == 2,
                        onTap: () => onItemSelected(2),
                      ),
                      DriverDrawerTile(
                        title: 'Assigned Route',
                        icon: Icons.route_outlined,
                        selected: selectedIndex == 3,
                        onTap: () => onItemSelected(3),
                      ),
                      DriverDrawerTile(
                        title: 'Bus Student Group',
                        icon: Icons.groups_outlined,
                        selected: selectedIndex == 4,
                        onTap: () => onItemSelected(4),
                      ),
                      DriverDrawerTile(
                        title: 'Live GPS Sharing',
                        icon: Icons.location_on_outlined,
                        selected: selectedIndex == 5,
                        onTap: () => onItemSelected(5),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                DriverDrawerTile(
                  title: 'Logout',
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
      },
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
            ? const Color(0xFF5B5FEF).withValues(alpha: 0.12)
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
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
