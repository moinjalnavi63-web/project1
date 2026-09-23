import 'package:flutter/material.dart';

import '../../drawer/admin_drawer.dart';
import '../widgets/admin_stat_card.dart';
import '../widgets/announcement_card.dart';
import '../../announcements/pages/announcement_details_screen.dart';

// ============================================================
// STUDENT PROFILES
// Same Student Profiles screen used by Admin Drawer
// ============================================================

import '../../student_profiles/pages/admin_student_profiles_screen.dart';

// IMPORTANT:
// This must point to the SAME demo_announcements.dart
// used by admin_announcement_screen.dart.
import '../../announcements/data/demo_announcements.dart';
import '../../bus_directory/pages/admin_bus_directory_screen.dart';
import '../../raise_token/pages/admin_raise_token_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Rebuild dashboard whenever this screen becomes active again.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // ==============================
      // ADMIN DRAWER
      // ==============================

      drawer: const AdminDrawer(),

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // ==============================
              // APP BAR
              // ==============================

              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,

                leading: IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 28,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),

                title: const Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                    ),
                    onPressed: () {
                      // Notifications screen will be connected later.
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // ==============================
              // DASHBOARD CONTENT
              // ==============================

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  30,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // ==============================
                      // STATISTICS
                      // ==============================

                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.15,
                        children: [
                          // ============================================
                          // STUDENTS
                          // CLICK → STUDENT PROFILES
                          // ============================================

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const AdminStudentProfilesScreen(),
                                ),
                              );
                            },
                            child: const AdminStatCard(
                              title: 'Students',
                              value: '1,250',
                              subtitle: 'Registered students',
                              icon: Icons.people_alt_outlined,
                              color: Colors.blue,
                            ),
                          ),

                          // ============================================
                          // BUSES
                          // CLICK → BUS DIRECTORY
                          // ============================================

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AdminBusDirectoryScreen(),
                                ),
                              );
                            },
                            child: const AdminStatCard(
                              title: 'Buses',
                              value: '24',
                              subtitle: 'Active buses',
                              icon: Icons.directions_bus_outlined,
                              color: Colors.green,
                            ),
                          ),

                          // ============================================
                          // OCCUPIED SEATS
                          // UNCHANGED
                          // ============================================

                          const AdminStatCard(
                            title: 'Occupied Seats',
                            value: '1,080',
                            subtitle: 'Currently occupied',
                            icon: Icons.event_seat_outlined,
                            color: Colors.orange,
                          ),

                          // ============================================
                          // PENDING TOKENS
                          // CLICK → ADMIN TOKEN MANAGEMENT
                          // ============================================

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AdminRaiseTokenScreen(),
                                ),
                              );
                            },
                            child: const AdminStatCard(
                              title: 'Pending Tokens',
                              value: '18',
                              subtitle: 'Need attention',
                              icon: Icons.confirmation_number_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // ==============================
                      // RECENT ANNOUNCEMENTS
                      // ==============================

                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Recent Announcements',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              // Announcements screen will be connected later.
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ==================================================
                      // ADMIN CREATED ANNOUNCEMENTS
                      // ==================================================

                      _buildCreatedAnnouncements(),

                      // ==================================================
                      // EXISTING ANNOUNCEMENTS
                      // ==================================================

                      const AnnouncementCard(
                        title: 'Bus Timing Update',
                        description:
                        'Bus timings have been updated. Students are requested to reach their pickup stops 10 minutes before the scheduled time.',
                        date: '03 Aug 2026',
                        target: 'All Students',
                      ),

                      const SizedBox(height: 12),

                      const AnnouncementCard(
                        title: 'Seat Allocation Notice',
                        description:
                        'Daily seat allocation has been updated. Please check your assigned seat before boarding the bus.',
                        date: '02 Aug 2026',
                        target: 'Students',
                      ),

                      const SizedBox(height: 12),

                      const AnnouncementCard(
                        title: 'Driver Meeting',
                        description:
                        'All drivers are requested to attend the transport department meeting.',
                        date: '01 Aug 2026',
                        target: 'Drivers',
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ADMIN CREATED ANNOUNCEMENTS
  // ============================================================

  Widget _buildCreatedAnnouncements() {
    if (demoAnnouncements.isEmpty) {
      return const SizedBox();
    }

    // Latest announcements are already inserted
    // at index 0 by AdminAnnouncementsScreen.
    final announcements =
    demoAnnouncements.take(3).toList();

    return Column(
      children: announcements.map((announcement) {
        return Column(
          children: [
            _createdAnnouncementCard(announcement),
            const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }

  // ============================================================
  // CREATED ANNOUNCEMENT CARD
  // NOW CLICKABLE
  // ============================================================

  Widget _createdAnnouncementCard(
      AnnouncementData announcement,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      // ==========================================================
      // OPEN ANNOUNCEMENT DETAILS
      // ==========================================================

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AnnouncementDetailsScreen(
              announcement: announcement,
            ),
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ========================================================
            // TITLE
            // ========================================================

            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,

                  decoration: BoxDecoration(
                    color: const Color(0xffede9fe),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.campaign_outlined,
                    color: Color(0xff6366f1),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    announcement.title,

                    maxLines: 2,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff111827),
                    ),
                  ),
                ),

                // Small indication that the card is clickable.
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ========================================================
            // TYPE
            // ========================================================

            Text(
              announcement.type,

              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff6366f1),
              ),
            ),

            const SizedBox(height: 6),

            // ========================================================
            // DESCRIPTION
            // ========================================================

            Text(
              announcement.description,

              maxLines: 3,

              overflow:
              TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 10),

            // ========================================================
            // ATTACHMENT
            // ========================================================

            if (announcement.hasAttachment) ...[
              Row(
                children: [
                  Icon(
                    announcement.isPdf
                        ? Icons.picture_as_pdf_outlined
                        : announcement.isImage
                        ? Icons.image_outlined
                        : Icons.attach_file,
                    size: 16,
                    color: const Color(0xff7c3aed),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Text(
                      announcement.attachmentName ??
                          'Attachment',

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7c3aed),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],

            // ========================================================
            // AUDIENCE + DATE
            // ========================================================

            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 15,
                  color: Colors.grey,
                ),

                const SizedBox(width: 5),

                Expanded(
                  child: Text(
                    announcement.targetAudience,

                    overflow:
                    TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  _formatAnnouncementDate(
                    announcement.dateTime,
                  ),

                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatAnnouncementDate(
      DateTime dateTime,
      ) {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;

    final minute =
    dateTime.minute.toString().padLeft(2, '0');

    final period =
    dateTime.hour >= 12 ? 'PM' : 'AM';

    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')} '
        '$hour:$minute $period';
  }
}