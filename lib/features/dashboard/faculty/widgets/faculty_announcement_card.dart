import 'package:flutter/material.dart';

import '../../../admin/announcements/data/demo_announcements.dart';
import '../../../admin/profile/data/admin_profile_data.dart';

class FacultyAnnouncementCard
    extends StatefulWidget {

  const FacultyAnnouncementCard({
    super.key,
  });

  @override
  State<FacultyAnnouncementCard> createState() =>
      _FacultyAnnouncementCardState();
}

class _FacultyAnnouncementCardState
    extends State<FacultyAnnouncementCard> {

  @override
  Widget build(BuildContext context) {

    final announcements =
    announcementsForRole(
      'faculty',
    );

    if (announcements.isEmpty) {
      return _emptyCard();
    }

    return Column(
      children: announcements.map(
            (announcement) {
          return Padding(
            padding:
            const EdgeInsets.only(
              bottom: 15,
            ),

            child: _buildCard(
              context,
              announcement,
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _emptyCard() {
    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
        Colors.white.withValues(
          alpha: .95,
        ),

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(
              alpha: .08,
            ),
            blurRadius: 12,
            offset:
            const Offset(0, 5),
          ),
        ],
      ),

      child: const Text(
        "No new announcements from the administration.",
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color:
          Color(0xFF374151),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      AnnouncementData announcement,
      ) {

    final liked =
    AnnouncementInteractionStore
        .isLiked(
      announcement.title,
    );

    final commentCount =
        AnnouncementInteractionStore
            .commentsFor(
          announcement.title,
        )
            .length;

    final admin =
        currentAdminProfile;

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
        Colors.white.withValues(
          alpha: .95,
        ),

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(
              alpha: .08,
            ),

            blurRadius: 12,

            offset:
            const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // =====================================================
          // ADMIN PROFILE
          // =====================================================

          Row(
            children: [

              const AdminProfileAvatar(
                radius: 24,
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      admin.name,

                      style:
                      const TextStyle(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      admin.role,

                      style: TextStyle(
                        fontSize: 11,
                        color:
                        Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                _dateText(
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

          const SizedBox(
            height: 14,
          ),

          const Divider(
            height: 1,
          ),

          const SizedBox(
            height: 14,
          ),

          // =====================================================
          // ANNOUNCEMENT TITLE
          // =====================================================

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Container(
                width: 48,
                height: 48,

                decoration:
                BoxDecoration(
                  color:
                  const Color(
                    0xFFEDE9FE,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),

                child: const Icon(
                  Icons
                      .campaign_outlined,

                  color:
                  Color(0xFF5B5FEF),

                  size: 27,
                ),
              ),

              const SizedBox(
                width: 13,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      announcement.title,

                      maxLines: 2,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      const TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      announcement.type,

                      style:
                      const TextStyle(
                        fontSize: 12,
                        color:
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 16,
          ),

          // =====================================================
          // DESCRIPTION
          // =====================================================

          Container(
            width: double.infinity,

            padding:
            const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color:
              const Color(
                0xFFF5F3FF,
              ),

              borderRadius:
              BorderRadius.circular(
                14,
              ),
            ),

            child: Text(
              announcement.description,

              maxLines: 4,

              overflow:
              TextOverflow.ellipsis,

              style:
              const TextStyle(
                fontSize: 14,
                height: 1.5,
                color:
                Color(0xFF374151),
              ),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // =====================================================
          // ACTIONS
          // =====================================================

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,

            children: [

              TextButton.icon(
                onPressed: () {
                  setState(() {
                    AnnouncementInteractionStore
                        .toggleLike(
                      announcement.title,
                    );
                  });
                },

                icon: Icon(
                  liked
                      ? Icons.thumb_up
                      : Icons
                      .thumb_up_outlined,
                ),

                label: Text(
                  liked
                      ? "Liked"
                      : "Like",
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  showAnnouncementComments(
                    context,
                    announcement,
                  ).then((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },

                icon: const Icon(
                  Icons
                      .comment_outlined,
                ),

                label: Text(
                  commentCount > 0
                      ? "Comment $commentCount"
                      : "Comment",
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  shareAnnouncement(
                    context,
                    announcement,
                  );
                },

                icon: const Icon(
                  Icons.share_outlined,
                ),

                label:
                const Text("Share"),
              ),
            ],
          ),

          // =====================================================
          // ATTACHMENT
          // =====================================================

          if (announcement.hasAttachment)
            TextButton.icon(
              onPressed: () {
                openAnnouncementAttachment(
                  context,
                  announcement,
                );
              },

              icon: Icon(
                announcement.isPdf
                    ? Icons
                    .picture_as_pdf_outlined
                    : Icons.attach_file,
              ),

              label: Text(
                announcement.isPdf
                    ? "PDF"
                    : "Attachment",
              ),
            ),
        ],
      ),
    );
  }

  String _dateText(
      DateTime dateTime,
      ) {
    final now = DateTime.now();

    final difference =
    now.difference(dateTime);

    if (difference.inHours < 24) {
      return "Today";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    return "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year}";
  }
}