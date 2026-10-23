import 'dart:io';

import 'package:flutter/material.dart';

import '../../../authentication/presentation/pages/login_screen.dart';
import '../../../dashboard/faculty/widgets/faculty_profile_photo.dart';

class FacultyDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const FacultyDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // FACULTY PROFILE HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 45,
              left: 20,
              right: 16,
              bottom: 22,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5B5FEF),
                  Color(0xFF7C83FD),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onItemSelected(-1);
                  },
                ),

                const SizedBox(height: 18),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<File?>(
                      valueListenable: facultyProfilePhotoNotifier,
                      builder: (context, photo, child) {
                        return Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: photo != null && photo.existsSync()
                                ? Image.file(
                              photo,
                              fit: BoxFit.cover,
                            )
                                : const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFF5B5FEF),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Faculty Name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          _FacultyDetail(
                            label: 'ID',
                            value: 'Faculty ID',
                          ),
                          SizedBox(height: 4),
                          _FacultyDetail(
                            label: 'Bus No.',
                            value: 'Not assigned',
                          ),
                          SizedBox(height: 4),
                          _FacultyDetail(
                            label: 'Route',
                            value: 'Not assigned',
                          ),
                          SizedBox(height: 4),
                          _FacultyDetail(
                            label: 'Stop',
                            value: 'Not assigned',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _drawerItem(
            icon: Icons.person_outline,
            title: 'Profile',
            index: 1,
          ),
          _drawerItem(
            icon: Icons.directions_bus_outlined,
            title: 'Bus Directory',
            index: 2,
          ),
          _drawerItem(
            icon: Icons.event_seat_outlined,
            title: 'Seat Allocator',
            index: 3,
          ),
          _drawerItem(
            icon: Icons.groups_outlined,
            title: 'Bus Group',
            index: 4,
          ),
          _drawerItem(
            icon: Icons.location_on_outlined,
            title: 'Live GPS Tracking',
            index: 5,
          ),
          _drawerItem(
            icon: Icons.confirmation_number_outlined,
            title: 'Raise Token',
            index: 6,
          ),

          const Spacer(),
          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
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

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected = selectedIndex == index;

    return ListTile(
      selected: selected,
      selectedTileColor: const Color(0xFFEDE9FE),
      leading: Icon(
        icon,
        color: selected
            ? const Color(0xFF5B5FEF)
            : Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected
              ? FontWeight.bold
              : FontWeight.w500,
          color: selected
              ? const Color(0xFF5B5FEF)
              : Colors.black87,
        ),
      ),
      onTap: () => onItemSelected(index),
    );
  }
}

class _FacultyDetail extends StatelessWidget {
  final String label;
  final String value;

  const _FacultyDetail({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 12,
      ),
    );
  }
}