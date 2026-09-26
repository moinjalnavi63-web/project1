import 'package:flutter/material.dart';

import '../../../admin/announcements/data/demo_announcements.dart';
import '../../../admin/profile/data/admin_profile_data.dart';

class DriverAnnouncementCard
    extends StatefulWidget {

  const DriverAnnouncementCard({
    super.key,
  });

  @override
  State<DriverAnnouncementCard> createState() =>
      _DriverAnnouncementCardState();
}

class _DriverAnnouncementCardState
    extends State<DriverAnnouncementCard> {

  @override
  Widget build(BuildContext context) {

    final announcements =
    announcementsForRole(
      'driver',
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

            child: DriverAnnouncementItem(
              announcement:
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
        Colors.white.withOpacity(.92),

        borderRadius:
        BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset:
            const Offset(0, 6),
          ),
        ],
      ),

      child: const Text(
        "No new announcements from the administration.",
        style: TextStyle(
          height: 1.5,
        ),
      ),
    );
  }
}

class DriverAnnouncementItem
    extends StatefulWidget {

  final AnnouncementData? announcement;

  final String? title;
  final String? description;
  final String? date;

  const DriverAnnouncementItem({
    super.key,
    this.announcement,
    this.title,
    this.description,
    this.date,
  });

  @override
  State<DriverAnnouncementItem> createState() =>
      _DriverAnnouncementItemState();
}

class _DriverAnnouncementItemState
    extends State<DriverAnnouncementItem> {

  AnnouncementData get announcement {

    if (widget.announcement != null) {
      return widget.announcement!;
    }

    return AnnouncementData(
      title:
      widget.title ??
          'Announcement',

      description:
      widget.description ??
          '',

      type:
      'General',

      targetAudience:
      'Drivers',

      dateTime:
      DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {

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
      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
        Colors.white.withOpacity(.92),

        borderRadius:
        BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.06),

            blurRadius: 12,

            offset:
            const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // ==================================================
          // ADMIN PROFILE
          // ==================================================

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
                        fontSize: 14,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    Text(
                      admin.role,

                      style:
                      const TextStyle(
                        fontSize: 11,
                        color:
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                _dateText(
                  announcement.dateTime,
                ),

                style:
                const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
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

          // ==================================================
          // ANNOUNCEMENT HEADER
          // ==================================================

          Row(
            children: [

              const Icon(
                Icons.campaign,
                color:
                Color(0xFF5B5FEF),
              ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: Text(
                  announcement.title,

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            announcement.type,

            style:
            const TextStyle(
              fontSize: 11,
              fontWeight:
              FontWeight.w600,
              color:
              Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            announcement.description,

            maxLines: 4,

            overflow:
            TextOverflow.ellipsis,

            style:
            const TextStyle(
              height: 1.4,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          const Divider(),

          const SizedBox(
            height: 5,
          ),

          // ==================================================
          // ACTIONS
          // ==================================================

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
                  Icons.share,
                ),

                label:
                const Text("Share"),
              ),
            ],
          ),

          // ==================================================
          // ATTACHMENT
          // ==================================================

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