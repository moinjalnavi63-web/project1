import 'package:flutter/material.dart';
import '../student_profiles/pages/admin_student_profiles_screen.dart';
import '../bus_directory/pages/admin_bus_directory_screen.dart';
import '../seat_allocator/pages/admin_seat_allocator_screen.dart';
import '../seat_allocator/pages/admin_seat_allocator_screen.dart';
import '../raise_token/pages/admin_raise_token_screen.dart';
import '../student_directory/pages/admin_student_directory_screen.dart';
import '../announcements/pages/admin_announcements_screen.dart';
class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // ==========================
            // HEADER
            // ==========================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff6366f1),
                    Color(0xff8b5cf6),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 34,
                      color: Colors.deepPurple,
                    ),
                  ),

                  SizedBox(height: 14),

                  Text(
                    'KUTS Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Transport Management',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ==========================
            // MENU
            // ==========================

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.people_outline,
                    title: 'Student Profiles',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminStudentProfilesScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.directions_bus_outlined,
                    title: 'Bus Directory',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminBusDirectoryScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.event_seat_outlined,
                    title: 'Seat Allocator',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminSeatAllocatorScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.confirmation_number_outlined,
                    title: 'Raise Token',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminRaiseTokenScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.groups_outlined,
                    title: 'Student Directory',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminStudentDirectoryScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.campaign_outlined,
                    title: 'Announcements',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminAnnouncementsScreen(),
                        ),
                      );
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            // ==========================
            // LOGOUT
            // ==========================

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}