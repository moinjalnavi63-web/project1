import 'dart:io';

import 'package:flutter/material.dart';

import '../../../bus_directory/pages/bus_directory_screen.dart';
import '../../../student_directory/pages/student_directory_screen.dart';

// Login Screen
import '../../../authentication/presentation/pages/login_screen.dart';

// Student profile photo
import '../../../profile/student/widgets/student_profile_header.dart';

class StudentDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const StudentDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // =====================================================
          // STUDENT PROFILE HEADER
          // =====================================================

          Container(
            width: double.infinity,

            padding: const EdgeInsets.only(
              top: 45,
              left: 16,
              right: 16,
              bottom: 20,
            ),

            decoration:
            const BoxDecoration(
              gradient: LinearGradient(
                begin:
                Alignment.topLeft,
                end:
                Alignment.bottomRight,

                colors: [
                  Color(0xFF5B5FEF),
                  Color(0xFF7C83FD),
                ],
              ),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // =================================================
                // BACK BUTTON
                // =================================================

                IconButton(
                  padding:
                  EdgeInsets.zero,

                  constraints:
                  const BoxConstraints(),

                  alignment:
                  Alignment.centerLeft,

                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),

                  onPressed: () {
                    Navigator.pop(
                      context,
                    );

                    onItemSelected(-1);
                  },
                ),

                const SizedBox(
                  height: 15,
                ),

                // =================================================
                // SAVED STUDENT PHOTO
                // =================================================

                Center(
                  child:
                  ValueListenableBuilder<File?>(
                    valueListenable:
                    studentProfilePhotoNotifier,

                    builder: (
                        context,
                        photo,
                        child,
                        ) {
                      return Container(
                        width: 75,
                        height: 75,

                        decoration:
                        const BoxDecoration(
                          shape:
                          BoxShape.circle,
                          color: Colors.white,
                        ),

                        padding:
                        const EdgeInsets.all(
                          3,
                        ),

                        child: ClipOval(
                          child: photo != null
                              ? Image.file(
                            photo,

                            width: 69,
                            height: 69,

                            fit: BoxFit.cover,
                          )
                              : const CircleAvatar(
                            radius: 35,

                            backgroundColor:
                            Colors.white,

                            child: Icon(
                              Icons.person,

                              size: 40,

                              color:
                              Color(
                                0xFF5B5FEF,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // =================================================
                // EXISTING STUDENT NAME
                // =================================================

                const Center(
                  child: Text(
                    "Mohammed Moinuddin",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                // =================================================
                // EXISTING USN
                // =================================================

                const Center(
                  child: Text(
                    "KUB24CSE118",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // PROFILE
          // =====================================================

          _drawerItem(
            icon:
            Icons.person_outline,
            title: "Profile",
            index: 1,
          ),

          // =====================================================
          // BUS DIRECTORY
          // =====================================================

          _drawerItem(
            icon:
            Icons.directions_bus_outlined,
            title: "Bus Directory",
            index: 2,
          ),

          // =====================================================
          // SEAT ALLOCATOR
          // =====================================================

          _drawerItem(
            icon:
            Icons.event_seat_outlined,
            title: "Seat Allocator",
            index: 3,
          ),

          // =====================================================
          // BUS GROUP
          // =====================================================

          _drawerItem(
            icon:
            Icons.groups_outlined,
            title: "Bus Group",
            index: 4,
          ),

          // =====================================================
          // LIVE GPS
          // =====================================================

          _drawerItem(
            icon:
            Icons.location_on_outlined,
            title: "Live GPS Tracking",
            index: 5,
          ),

          // =====================================================
          // RAISE TOKEN
          // =====================================================

          _drawerItem(
            icon:
            Icons.confirmation_number_outlined,
            title: "Raise Token",
            index: 6,
          ),

          // =====================================================
          // STUDENT DIRECTORY
          // =====================================================

          ListTile(
            selected:
            selectedIndex == 8,

            selectedTileColor:
            const Color(0xFFEDE9FE),

            leading: Icon(
              Icons.people_outline,

              color:
              selectedIndex == 8
                  ? const Color(
                0xFF5B5FEF,
              )
                  : Colors.black87,
            ),

            title: Text(
              "Student Directory",

              style: TextStyle(
                fontWeight:
                selectedIndex == 8
                    ? FontWeight.bold
                    : FontWeight.w500,

                color:
                selectedIndex == 8
                    ? const Color(
                  0xFF5B5FEF,
                )
                    : Colors.black87,
              ),
            ),

            onTap: () {
              Navigator.pop(
                context,
              );

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                  const StudentDirectoryScreen(
                    role: "student",
                  ),
                ),
              );
            },
          ),

          const Spacer(),

          const Divider(),

          // =====================================================
          // LOGOUT
          // =====================================================

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),

            title: const Text(
              "Logout",

              style: TextStyle(
                color: Colors.red,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            onTap: () {
              Navigator.pop(
                context,
              );

              Navigator.of(context)
                  .pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) =>
                  const LoginScreen(),
                ),
                    (route) => false,
              );
            },
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DRAWER ITEM
  // ============================================================

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected =
        selectedIndex == index;

    return ListTile(
      selected: selected,

      selectedTileColor:
      const Color(0xFFEDE9FE),

      leading: Icon(
        icon,

        color: selected
            ? const Color(
          0xFF5B5FEF,
        )
            : Colors.black87,
      ),

      title: Text(
        title,

        style: TextStyle(
          fontWeight:
          selected
              ? FontWeight.bold
              : FontWeight.w500,

          color: selected
              ? const Color(
            0xFF5B5FEF,
          )
              : Colors.black87,
        ),
      ),

      onTap: () =>
          onItemSelected(index),
    );
  }
}