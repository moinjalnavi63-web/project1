import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import '../data/demo_announcements.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final AnnouncementData announcement;

  const AnnouncementDetailsScreen({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f7fb),

      appBar: AppBar(
        title: const Text(
          'Announcement',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xff111827),
      ),

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
          top: false,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ==================================================
                // MAIN CARD
                // ==================================================

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.06,
                        ),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                      // ==================================================
                      // ICON + TYPE
                      // ==================================================

                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Container(
                            width: 52,
                            height: 52,

                            decoration: BoxDecoration(
                              color:
                              const Color(0xffede9fe),
                              borderRadius:
                              BorderRadius.circular(14),
                            ),

                            child: const Icon(
                              Icons.campaign_outlined,
                              size: 28,
                              color: Color(0xff6366f1),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                Text(
                                  announcement.type,

                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w700,
                                    color:
                                    Color(0xff6366f1),
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  announcement.title,

                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    Color(0xff111827),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      const Divider(),

                      const SizedBox(height: 18),

                      // ==================================================
                      // COMPLETE MESSAGE
                      // ==================================================

                      const Text(
                        'Announcement Details',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff111827),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        announcement.description,

                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // AUDIENCE
                      // ==================================================

                      _infoRow(
                        icon: Icons.people_outline,
                        title: 'Audience',
                        value:
                        announcement.targetAudience,
                      ),

                      const SizedBox(height: 14),

                      // ==================================================
                      // DATE
                      // ==================================================

                      _infoRow(
                        icon:
                        Icons.calendar_today_outlined,
                        title: 'Published',
                        value:
                        _formatDate(
                          announcement.dateTime,
                        ),
                      ),

                      // ==================================================
                      // ATTACHMENT
                      // ==================================================

                      if (announcement.hasAttachment) ...[
                        const SizedBox(height: 24),

                        const Divider(),

                        const SizedBox(height: 18),

                        const Text(
                          'Attachment',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff111827),
                          ),
                        ),

                        const SizedBox(height: 10),

                        _attachmentCard(context),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // INFO ROW
  // ==============================================================

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: const Color(0xfff9fafb),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: const Color(0xffe0e7ff),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              size: 20,
              color: const Color(0xff4f46e5),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff111827),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ATTACHMENT CARD
  // ==============================================================

  Widget _attachmentCard(BuildContext context) {
    final String extension =
        announcement.attachmentType?.toLowerCase() ?? '';

    IconData icon;

    if (extension == 'pdf') {
      icon = Icons.picture_as_pdf_outlined;
    } else if (extension == 'image') {
      icon = Icons.image_outlined;
    } else {
      icon = Icons.description_outlined;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(15),

      onTap: () {
        _openAttachment(context);
      },

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: const Color(0xfff9fafb),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,

              decoration: BoxDecoration(
                color: const Color(0xffede9fe),
                borderRadius:
                BorderRadius.circular(11),
              ),

              child: Icon(
                icon,
                color: const Color(0xff7c3aed),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    announcement.attachmentName ??
                        'Attached file',

                    maxLines: 2,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff111827),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Tap to open',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.open_in_new_rounded,
              size: 20,
              color: Color(0xff6366f1),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // OPEN ATTACHMENT
  // ==============================================================

  Future<void> _openAttachment(
      BuildContext context,
      ) async {
    final String? path =
        announcement.attachmentPath;

    if (path == null || path.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Attachment file is not available.',
          ),
        ),
      );

      return;
    }

    try {
      final result = await OpenFilex.open(path);

      if (!context.mounted) return;

      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              result.message.isNotEmpty
                  ? result.message
                  : 'Unable to open this file.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Unable to open the attachment.',
          ),
        ),
      );
    }
  }

  // ==============================================================
  // DATE FORMAT
  // ==============================================================

  String _formatDate(DateTime dateTime) {
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
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} '
        '$hour:$minute $period';
  }
}