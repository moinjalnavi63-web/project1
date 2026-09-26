import 'package:flutter/material.dart';

import '../data/demo_announcements.dart';

class AdminAnnouncementCard extends StatelessWidget {
  final AnnouncementData announcement;
  final VoidCallback onDelete;

  const AdminAnnouncementCard({
    super.key,
    required this.announcement,
    required this.onDelete,
  });

  Widget _adminAvatar() {
    final String? photo =
        announcement.adminPhotoPath;

    if (photo != null &&
        photo.trim().isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundColor:
        const Color(0xffede9fe),
        backgroundImage:
        AssetImage(photo),
      );
    }

    final String name =
    announcement.adminName.trim();

    final String firstLetter =
    name.isNotEmpty
        ? name[0].toUpperCase()
        : 'A';

    return CircleAvatar(
      radius: 24,
      backgroundColor:
      const Color(0xffede9fe),
      child: Text(
        firstLetter,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // =====================================================
          // ADMIN PROFILE HEADER
          // =====================================================

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              // ADMIN PHOTO
              _adminAvatar(),

              const SizedBox(width: 12),

              // ADMIN INFORMATION
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      announcement.adminName,

                      style:
                      const TextStyle(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Transport Administrator',

                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      _formatDate(
                        announcement.dateTime,
                      ),

                      style: TextStyle(
                        fontSize: 10,
                        color:
                        Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // DELETE MENU
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },

                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'delete',

                    child: Row(
                      children: [

                        Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),

                        SizedBox(width: 8),

                        Text(
                          'Delete',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(
            height: 1,
          ),

          const SizedBox(height: 14),

          // =====================================================
          // ANNOUNCEMENT TITLE
          // =====================================================

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color:
                  Colors.deepPurple.shade50,

                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.campaign_outlined,

                  color:
                  Colors.deepPurple,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      announcement.title,

                      style:
                      const TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      announcement.type,

                      style: TextStyle(
                        fontSize: 12,
                        color:
                        Colors.deepPurple.shade700,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // =====================================================
          // DESCRIPTION
          // =====================================================

          Text(
            announcement.description,

            style: TextStyle(
              fontSize: 14,
              color:
              Colors.grey.shade700,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          // =====================================================
          // TARGET AUDIENCE
          // =====================================================

          Row(
            children: [

              const Icon(
                Icons.people_outline,
                size: 17,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  'Audience: ${announcement.targetAudience}',

                  style:
                  const TextStyle(
                    fontSize: 12,
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // =====================================================
          // ATTACHMENT
          // =====================================================

          if (announcement.hasAttachment) ...[
            const SizedBox(height: 12),

            Container(
              padding:
              const EdgeInsets.all(11),

              decoration: BoxDecoration(
                color:
                Colors.grey.shade50,

                borderRadius:
                BorderRadius.circular(12),

                border: Border.all(
                  color:
                  Colors.grey.shade200,
                ),
              ),

              child: Row(
                children: [

                  Icon(
                    announcement.isPdf
                        ? Icons.picture_as_pdf
                        : announcement.isImage
                        ? Icons.image
                        : Icons.description,

                    color:
                    announcement.isPdf
                        ? Colors.red
                        : Colors.deepPurple,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      announcement.attachmentName!,

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style:
                      const TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.attach_file,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // =====================================================
          // DATE
          // =====================================================

          Row(
            children: [

              Icon(
                Icons.access_time,
                size: 15,
                color:
                Colors.grey.shade600,
              ),

              const SizedBox(width: 5),

              Text(
                _formatDate(
                  announcement.dateTime,
                ),

                style: TextStyle(
                  fontSize: 11,
                  color:
                  Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(DateTime date) {
    final hour =
    date.hour.toString().padLeft(2, '0');

    final minute =
    date.minute.toString().padLeft(2, '0');

    return '${date.day}/${date.month}/${date.year} • $hour:$minute';
  }
}