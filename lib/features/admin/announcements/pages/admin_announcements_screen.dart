import 'package:flutter/material.dart';

import '../data/demo_announcements.dart';
import '../widgets/admin_announcement_card.dart';
import 'create_announcement_screen.dart';

class AdminAnnouncementsScreen extends StatefulWidget {
  const AdminAnnouncementsScreen({super.key});

  @override
  State<AdminAnnouncementsScreen> createState() =>
      _AdminAnnouncementsScreenState();
}

class _AdminAnnouncementsScreenState
    extends State<AdminAnnouncementsScreen> {
  String selectedFilter = 'All';

  List<AnnouncementData> get filteredAnnouncements {
    if (selectedFilter == 'All') {
      return demoAnnouncements;
    }

    return demoAnnouncements
        .where(
          (announcement) =>
      announcement.type == selectedFilter,
    )
        .toList();
  }

  Future<void> _openCreateAnnouncement() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateAnnouncementScreen(),
      ),
    );

    if (result is AnnouncementData) {
      setState(() {
        demoAnnouncements.insert(0, result);
      });
    }
  }

  void _deleteAnnouncement(int index) {
    final announcement = filteredAnnouncements[index];

    final actualIndex =
    demoAnnouncements.indexOf(announcement);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Announcement?'),
          content: const Text(
            'This announcement will be removed from the admin announcement list.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  demoAnnouncements.removeAt(actualIndex);
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final announcements = filteredAnnouncements;

    return Scaffold(
      backgroundColor: const Color(0xfff4f7fb),
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Create Announcement',
            onPressed: _openCreateAnnouncement,
            icon: const Icon(
              Icons.add_circle_outline,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateAnnouncement,
        icon: const Icon(Icons.campaign_outlined),
        label: const Text('Create'),
      ),
      body: Container(
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
          top: false,
          child: Column(
            children: [
              _header(),

              const SizedBox(height: 12),

              _filterBar(),

              const SizedBox(height: 12),

              Expanded(
                child: announcements.isEmpty
                    ? _emptyState()
                    : RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(
                      const Duration(
                        milliseconds: 500,
                      ),
                    );

                    setState(() {});
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      100,
                    ),
                    itemCount: announcements.length,
                    itemBuilder: (
                        context,
                        index,
                        ) {
                      final announcement =
                      announcements[index];

                      return AdminAnnouncementCard(
                        announcement:
                        announcement,
                        onDelete: () {
                          _deleteAnnouncement(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transport Communication',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Publish important information to students, drivers and faculty.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Text(
              '${demoAnnouncements.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterBar() {
    const filters = [
      'All',
      'Transportation Details',
      'Transport Alert',
      'General',
      'Notice / Circular',
      'Emergency',
      'Bus Specific',
      'Route / Stop',
    ];

    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final filter = filters[index];
          final selected =
              selectedFilter == filter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedFilter = filter;
              });
            },
          );
        },
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 70,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Announcements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create an announcement to share information with users.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
