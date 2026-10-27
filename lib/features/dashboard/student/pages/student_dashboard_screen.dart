
import 'package:flutter/material.dart';

import '../widgets/student_drawer.dart';
import '../widgets/student_home.dart';

import '../../../seat_allocator/pages/seat_allocator_screen.dart';
import '../../../profile/student/pages/student_profile_screen.dart';
import '../../../bus_directory/pages/bus_directory_screen.dart';
import '../../../raise_token/screens/raise_token_screen.dart';
import '../../../gps_tracking/pages/live_gps_tracking_screen.dart';
import '../../../bus_group/pages/bus_group_screen.dart';

import '../../../admin/announcements/data/demo_announcements.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() =>
      _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int selectedIndex = 0;

  // ============================================================
  // STUDENT DASHBOARD PAGES
  // ============================================================

  late final List<Widget> pages = [
    const StudentHome(),

    const StudentProfileScreen(),

    const BusDirectoryScreen(),

    const SeatAllocatorScreen(),

    // BUS GROUP CHAT
    const BusGroupScreen(
      busName: 'Bus 01',
      routeName: 'Hospet Route',
      currentUserName: 'Mohammed Moinuddin',
      currentUserRole: 'Student',
    ),

    const LiveGpsTrackingScreen(),

    const RaiseTokenScreen(),

    const Center(
      child: Text('Announcements'),
    ),

    const Center(
      child: Text('Student Directory'),
    ),
  ];

  // ============================================================
  // PAGE TITLES
  // ============================================================

  final List<String> titles = const [
    'Welcome to KUTS',
    'Profile',
    'Bus Directory',
    'Seat Allocator',
    'Bus Group',
    'Live GPS Tracking',
    'Raise Token',
    'Announcements',
    'Student Directory',
  ];

  // ============================================================
  // DASHBOARD NAVIGATION
  // ============================================================

  void changePage(int index) {
    if (!mounted) return;

    // Return to Student Home when the drawer back arrow is pressed.
    if (index == -1) {
      setState(() {
        selectedIndex = 0;
      });
      return;
    }

    // Prevent invalid page indexes.
    if (index < 0 || index >= pages.length) {
      return;
    }

    // Change the page without pushing or popping dashboard routes.
    setState(() {
      selectedIndex = index;
    });
  }

  // ============================================================
  // ANNOUNCEMENT SEARCH
  // ============================================================

  void openSearch() {
    showAnnouncementSearch(
      context,
      'student',
    );
  }

  // ============================================================
  // ANNOUNCEMENT NOTIFICATIONS
  // ============================================================

  void openNotifications() {
    showAnnouncementNotifications(
      context,
      'student',
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final List<AnnouncementData> studentAnnouncements =
    announcementsForRole('student');

    final int unread = AnnouncementInteractionStore.unreadCount(
      studentAnnouncements,
    );

    return Scaffold(
      drawer: StudentDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: changePage,
      ),

      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        centerTitle: true,
        actions: [
          // SEARCH
          IconButton(
            tooltip: 'Search announcements',
            icon: const Icon(Icons.search),
            onPressed: openSearch,
          ),

          // NOTIFICATIONS
          Stack(
            children: [
              IconButton(
                tooltip: 'Notifications',
                icon: const Icon(Icons.notifications_none),
                onPressed: openNotifications,
              ),

              if (unread > 0)
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 17,
                      minHeight: 17,
                    ),
                    child: Text(
                      unread > 9 ? '9+' : '$unread',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      // SELECTED PAGE
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey<int>(selectedIndex),
          child: pages[selectedIndex],
        ),
      ),
    );
  }
}
