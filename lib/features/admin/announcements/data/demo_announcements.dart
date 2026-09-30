import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../profile/data/admin_profile_data.dart';
import '../pages/announcement_details_screen.dart';

// ============================================================
// ANNOUNCEMENT DATA MODEL
// ============================================================

class AnnouncementData {
  final String title;
  final String description;
  final String type;
  final String targetAudience;
  final DateTime dateTime;

  // Attachment information
  final String? attachmentName;
  final String? attachmentPath;
  final String? attachmentType;

  // Admin information
  final String adminName;
  final String? adminPhotoPath;

  AnnouncementData({
    required this.title,
    required this.description,
    required this.type,
    required this.targetAudience,
    required this.dateTime,
    this.attachmentName,
    this.attachmentPath,
    this.attachmentType,
    String? adminName,
    String? adminPhotoPath,
  })  : adminName =
      adminName ?? currentAdminProfile.name,
        adminPhotoPath =
            adminPhotoPath ?? currentAdminProfile.profilePhoto;

  bool get hasAttachment =>
      attachmentName != null &&
          attachmentName!.isNotEmpty;

  bool get isPdf =>
      attachmentType == 'pdf';

  bool get isImage =>
      attachmentType == 'image';

  bool get isDocument =>
      attachmentType == 'document';
}

// ============================================================
// DEMO ANNOUNCEMENTS
// ============================================================

final List<AnnouncementData> demoAnnouncements = [
  AnnouncementData(
    title: 'Bus Transportation Details',
    description:
    'Students are requested to check their bus number, route and pickup stop before travelling to the university.',
    type: 'Transportation Details',
    targetAudience: 'All students',
    dateTime: DateTime.now().subtract(
      const Duration(hours: 2),
    ),
  ),

  AnnouncementData(
    title: 'Bus 1 Route Update',
    description:
    'Bus 1 will follow the Hospet → Gangavathi → Koppal route tomorrow.',
    type: 'Bus Specific',
    targetAudience: 'Bus 1',
    dateTime: DateTime.now().subtract(
      const Duration(days: 1),
    ),
  ),

  AnnouncementData(
    title: 'Important Transport Notice',
    description:
    'Students should reach their respective pickup stops at least 10 minutes before the scheduled arrival time.',
    type: 'Notice / Circular',
    targetAudience: 'All students',
    dateTime: DateTime.now().subtract(
      const Duration(days: 2),
    ),
  ),
];

// ============================================================
// ANNOUNCEMENT INTERACTION STORE
// ============================================================

class AnnouncementInteractionStore {
  static final Set<String> likedAnnouncements =
  <String>{};

  static final Map<String, List<String>> comments =
  <String, List<String>>{};

  static final Set<String> readNotifications =
  <String>{};

  static bool isLiked(String title) {
    return likedAnnouncements.contains(title);
  }

  static void toggleLike(String title) {
    if (likedAnnouncements.contains(title)) {
      likedAnnouncements.remove(title);
    } else {
      likedAnnouncements.add(title);
    }
  }

  static List<String> commentsFor(String title) {
    return comments[title] ?? <String>[];
  }

  static void addComment(
      String title,
      String comment,
      ) {
    final String cleanedComment =
    comment.trim();

    if (cleanedComment.isEmpty) {
      return;
    }

    comments.putIfAbsent(
      title,
          () => <String>[],
    );

    comments[title]!.add(
      cleanedComment,
    );
  }

  static bool isRead(String title) {
    return readNotifications.contains(title);
  }

  static void markAsRead(String title) {
    readNotifications.add(title);
  }

  static int unreadCount(
      List<AnnouncementData> announcements,
      ) {
    return announcements
        .where(
          (announcement) =>
      !isRead(announcement.title),
    )
        .length;
  }
}

// ============================================================
// ANNOUNCEMENT VISIBILITY
// ============================================================

List<AnnouncementData> announcementsForRole(
    String role,
    ) {
  final String normalizedRole =
  role.toLowerCase();

  return demoAnnouncements.where(
        (announcement) {
      final String audience =
      announcement.targetAudience
          .toLowerCase();

      // --------------------------------------------------------
      // GLOBAL ANNOUNCEMENTS
      // --------------------------------------------------------

      if (audience.contains('everyone') ||
          audience.contains('all')) {
        return true;
      }

      // --------------------------------------------------------
      // STUDENT ANNOUNCEMENTS
      // --------------------------------------------------------

      if (normalizedRole == 'student') {
        return audience.contains('student') ||
            audience.contains('bus') ||
            audience.contains('route');
      }

      // --------------------------------------------------------
      // FACULTY ANNOUNCEMENTS
      // --------------------------------------------------------

      if (normalizedRole == 'faculty') {
        return audience.contains('faculty');
      }

      // --------------------------------------------------------
      // DRIVER ANNOUNCEMENTS
      // --------------------------------------------------------

      if (normalizedRole == 'driver') {
        return audience.contains('driver');
      }

      return false;
    },
  ).toList();
}

// ============================================================
// SEARCH ANNOUNCEMENTS
// ============================================================
//
// Search uses a dedicated StatefulWidget.
// This prevents the temporary StatefulBuilder/controller
// lifecycle from causing:
//
// '_dependents.isEmpty': is not true
//
// ============================================================

Future<AnnouncementData?> showAnnouncementSearch(
    BuildContext context,
    String role,
    ) async {
  final List<AnnouncementData> announcements =
  announcementsForRole(role);

  final AnnouncementData? result =
  await showDialog<AnnouncementData>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return _AnnouncementSearchDialog(
        announcements: announcements,
      );
    },
  );

  // ----------------------------------------------------------
  // Open announcement details only after the dialog has fully
  // returned and been removed from the widget tree.
  // ----------------------------------------------------------

  if (result != null && context.mounted) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AnnouncementDetailsScreen(
              announcement: result,
            ),
      ),
    );
  }

  return result;
}

// ============================================================
// SEARCH DIALOG
// ============================================================

class _AnnouncementSearchDialog
    extends StatefulWidget {
  final List<AnnouncementData> announcements;

  const _AnnouncementSearchDialog({
    required this.announcements,
  });

  @override
  State<_AnnouncementSearchDialog>
  createState() =>
      _AnnouncementSearchDialogState();
}

class _AnnouncementSearchDialogState
    extends State<_AnnouncementSearchDialog> {
  late final TextEditingController
  _controller;

  String _query = '';

  @override
  void initState() {
    super.initState();

    _controller =
        TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  List<AnnouncementData>
  _filteredAnnouncements() {
    final String query =
    _query.trim().toLowerCase();

    if (query.isEmpty) {
      return widget.announcements;
    }

    return widget.announcements
        .where(
          (announcement) {
        return announcement.title
            .toLowerCase()
            .contains(query) ||
            announcement.description
                .toLowerCase()
                .contains(query) ||
            announcement.type
                .toLowerCase()
                .contains(query) ||
            announcement.targetAudience
                .toLowerCase()
                .contains(query);
      },
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<AnnouncementData>
    filtered =
    _filteredAnnouncements();

    return AlertDialog(
      title: const Text(
        'Search KUTS',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      content: SizedBox(
        width: double.maxFinite,
        height: 430,

        child: Column(
          children: [

            // ------------------------------------------------
            // SEARCH FIELD
            // ------------------------------------------------

            TextField(
              controller: _controller,

              autofocus: true,

              textInputAction:
              TextInputAction.search,

              decoration:
              InputDecoration(
                hintText:
                'Search announcements...',

                prefixIcon:
                const Icon(
                  Icons.search,
                ),

                suffixIcon:
                _controller.text
                    .isNotEmpty
                    ? IconButton(
                  icon:
                  const Icon(
                    Icons.clear,
                  ),
                  onPressed: () {
                    _controller
                        .clear();

                    setState(() {
                      _query = '';
                    });
                  },
                )
                    : null,

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),
              ),

              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),

            const SizedBox(
              height: 15,
            ),

            // ------------------------------------------------
            // SEARCH RESULTS
            // ------------------------------------------------

            Expanded(
              child:
              filtered.isEmpty
                  ? const Center(
                child: Text(
                  'No announcements found.',
                  textAlign:
                  TextAlign.center,
                ),
              )
                  : ListView.separated(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                itemCount:
                filtered.length,

                separatorBuilder:
                    (_, __) =>
                const Divider(),

                itemBuilder:
                    (context, index) {
                  final AnnouncementData
                  announcement =
                  filtered[index];

                  return ListTile(
                    contentPadding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),

                    leading:
                    Container(
                      width: 42,
                      height: 42,

                      decoration:
                      BoxDecoration(
                        color:
                        const Color(
                          0xffede9fe,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          12,
                        ),
                      ),

                      child:
                      const Icon(
                        Icons
                            .campaign_outlined,

                        color:
                        Color(
                          0xff6366f1,
                        ),
                      ),
                    ),

                    title: Text(
                      announcement
                          .title,

                      maxLines: 2,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    subtitle:
                    Text(
                      announcement
                          .description,

                      maxLines: 2,

                      overflow:
                      TextOverflow
                          .ellipsis,
                    ),

                    trailing:
                    const Icon(
                      Icons
                          .chevron_right,
                    ),

                    onTap: () {
                      Navigator.of(
                        context,
                      ).pop(
                        announcement,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// NOTIFICATIONS
// ============================================================

Future<AnnouncementData?>
showAnnouncementNotifications(
    BuildContext context,
    String role,
    ) async {
  final List<AnnouncementData>
  announcements =
  announcementsForRole(role);

  final AnnouncementData? result =
  await showModalBottomSheet<
      AnnouncementData>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    builder: (sheetContext) {
      return Container(
        height:
        MediaQuery.of(context)
            .size
            .height *
            .75,

        decoration:
        const BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),

        child: Column(
          children: [

            const SizedBox(
              height: 12,
            ),

            Container(
              width: 45,
              height: 5,

              decoration:
              BoxDecoration(
                color:
                Colors.grey.shade300,

                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                20,
                18,
                12,
                10,
              ),

              child: Row(
                children: [

                  const Expanded(
                    child: Text(
                      'Notifications',

                      style:
                      TextStyle(
                        fontSize: 21,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  if (announcements
                      .isNotEmpty)
                    TextButton(
                      onPressed: () {
                        for (
                        final AnnouncementData
                        announcement
                        in announcements
                        ) {
                          AnnouncementInteractionStore
                              .markAsRead(
                            announcement
                                .title,
                          );
                        }

                        Navigator.pop(
                          sheetContext,
                        );

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger
                            .of(
                          context,
                        )
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'All notifications marked as read.',
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        'Mark all read',
                      ),
                    ),
                ],
              ),
            ),

            const Divider(
              height: 1,
            ),

            Expanded(
              child:
              announcements.isEmpty
                  ? const Center(
                child: Text(
                  'No notifications available.',

                  style:
                  TextStyle(
                    color:
                    Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                padding:
                const EdgeInsets
                    .all(
                  14,
                ),

                itemCount:
                announcements
                    .length,

                itemBuilder:
                    (context,
                    index) {
                  final AnnouncementData
                  announcement =
                  announcements[
                  index];

                  final bool read =
                  AnnouncementInteractionStore
                      .isRead(
                    announcement
                        .title,
                  );

                  return Card(
                    elevation: 0,

                    color: read
                        ? Colors
                        .grey
                        .shade50
                        : const Color(
                      0xffeef2ff,
                    ),

                    margin:
                    const EdgeInsets
                        .only(
                      bottom: 10,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        16,
                      ),
                    ),

                    child: ListTile(
                      contentPadding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 15,
                        vertical: 7,
                      ),

                      leading:
                      CircleAvatar(
                        backgroundColor:
                        const Color(
                          0xffe0e7ff,
                        ),

                        child:
                        Icon(
                          read
                              ? Icons
                              .notifications_none
                              : Icons
                              .notifications_active,

                          color:
                          const Color(
                            0xff4f46e5,
                          ),
                        ),
                      ),

                      title: Text(
                        announcement
                            .title,

                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),

                      subtitle:
                      Text(
                        announcement
                            .description,

                        maxLines: 2,

                        overflow:
                        TextOverflow
                            .ellipsis,
                      ),

                      trailing: read
                          ? null
                          : Container(
                        width: 9,
                        height: 9,

                        decoration:
                        const BoxDecoration(
                          color:
                          Colors.red,

                          shape:
                          BoxShape
                              .circle,
                        ),
                      ),

                      onTap: () {
                        AnnouncementInteractionStore
                            .markAsRead(
                          announcement
                              .title,
                        );

                        Navigator.pop(
                          sheetContext,
                          announcement,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  // ----------------------------------------------------------
  // OPEN NOTIFICATION DETAILS
  // ----------------------------------------------------------

  if (result != null && context.mounted) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AnnouncementDetailsScreen(
              announcement: result,
            ),
      ),
    );
  }

  return result;
}

// ============================================================
// COMMENTS
// ============================================================
//
// IMPORTANT FIX:
//
// This is now a dedicated StatefulWidget instead of a
// StatefulBuilder.
//
// The TextEditingController belongs to the comments sheet and
// is disposed by the sheet itself.
//
// This prevents the previous:
//
// '_dependents.isEmpty': is not true
//
// crash when:
// 1. User opens comments.
// 2. User writes a comment.
// 3. User sends the comment.
// 4. User pulls the bottom sheet down.
// ============================================================

Future<void> showAnnouncementComments(
    BuildContext context,
    AnnouncementData announcement,
    ) async {
  await showModalBottomSheet(
    context: context,

    isScrollControlled: true,

    backgroundColor:
    Colors.transparent,

    // Prevent the sheet from requesting
    // focus again during route transitions.
    requestFocus: false,

    builder: (sheetContext) {
      return _AnnouncementCommentsSheet(
        announcement: announcement,
      );
    },
  );
}

// ============================================================
// COMMENTS SHEET STATEFUL WIDGET
// ============================================================

class _AnnouncementCommentsSheet
    extends StatefulWidget {
  final AnnouncementData announcement;

  const _AnnouncementCommentsSheet({
    required this.announcement,
  });

  @override
  State<_AnnouncementCommentsSheet>
  createState() =>
      _AnnouncementCommentsSheetState();
}

class _AnnouncementCommentsSheetState
    extends State<_AnnouncementCommentsSheet> {
  late final TextEditingController
  _controller;

  final FocusNode _commentFocusNode =
  FocusNode();

  @override
  void initState() {
    super.initState();

    _controller =
        TextEditingController();
  }

  @override
  void dispose() {
    // Remove focus before disposing the
    // controller/focus node.
    _commentFocusNode.unfocus();

    _commentFocusNode.dispose();

    _controller.dispose();

    super.dispose();
  }

  void _addComment() {
    final String text =
    _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    AnnouncementInteractionStore
        .addComment(
      widget.announcement.title,
      text,
    );

    _controller.clear();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> comments =
    AnnouncementInteractionStore
        .commentsFor(
      widget.announcement.title,
    );

    final double keyboardHeight =
        MediaQuery.viewInsetsOf(context)
            .bottom;

    return SafeArea(
      top: false,

      child: Padding(
        padding: EdgeInsets.only(
          bottom: keyboardHeight,
        ),

        child: Container(
          height:
          MediaQuery.sizeOf(context)
              .height *
              .65,

          decoration:
          const BoxDecoration(
            color: Colors.white,

            borderRadius:
            BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),

          child: Column(
            children: [

              // ------------------------------------------------
              // DRAG HANDLE
              // ------------------------------------------------

              const SizedBox(
                height: 12,
              ),

              Container(
                width: 45,
                height: 5,

                decoration:
                BoxDecoration(
                  color:
                  Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(
                    10,
                  ),
                ),
              ),

              // ------------------------------------------------
              // COMMENTS HEADER
              // ------------------------------------------------

              Padding(
                padding:
                const EdgeInsets.all(
                  18,
                ),

                child: Row(
                  children: [

                    const Expanded(
                      child: Text(
                        'Comments',

                        style:
                        TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      '${comments.length}',

                      style: TextStyle(
                        color: Colors
                            .grey
                            .shade600,

                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 1,
              ),

              // ------------------------------------------------
              // COMMENT LIST
              // ------------------------------------------------

              Expanded(
                child: comments.isEmpty
                    ? const Center(
                  child: Text(
                    'No comments yet.\nBe the first to comment.',

                    textAlign:
                    TextAlign.center,

                    style:
                    TextStyle(
                      color:
                      Colors.grey,
                    ),
                  ),
                )
                    : ListView.builder(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

                  padding:
                  const EdgeInsets
                      .all(
                    15,
                  ),

                  itemCount:
                  comments.length,

                  itemBuilder:
                      (context,
                      index) {
                    return Container(
                      margin:
                      const EdgeInsets
                          .only(
                        bottom: 10,
                      ),

                      padding:
                      const EdgeInsets
                          .all(
                        13,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        const Color(
                          0xfff5f7fb,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          14,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          const CircleAvatar(
                            radius: 17,

                            child:
                            Icon(
                              Icons
                                  .person,
                              size: 18,
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child:
                            Text(
                              comments[
                              index],

                              style:
                              const TextStyle(
                                fontSize:
                                14,
                                height:
                                1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ------------------------------------------------
              // COMMENT INPUT
              // ------------------------------------------------

              Padding(
                padding:
                const EdgeInsets
                    .fromLTRB(
                  12,
                  8,
                  12,
                  12,
                ),

                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .end,

                  children: [

                    Expanded(
                      child:
                      TextField(
                        controller:
                        _controller,

                        focusNode:
                        _commentFocusNode,

                        textInputAction:
                        TextInputAction
                            .send,

                        minLines: 1,

                        maxLines: 4,

                        decoration:
                        InputDecoration(
                          hintText:
                          'Write a comment...',

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              14,
                            ),
                          ),
                        ),

                        onSubmitted:
                            (_) {
                          _addComment();
                        },
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    IconButton(
                      style:
                      IconButton
                          .styleFrom(
                        backgroundColor:
                        const Color(
                          0xff4f46e5,
                        ),

                        foregroundColor:
                        Colors.white,
                      ),

                      onPressed:
                      _addComment,

                      icon:
                      const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SHARE ANNOUNCEMENT
// ============================================================

Future<void> shareAnnouncement(
    BuildContext context,
    AnnouncementData announcement,
    ) async {
  try {
    await Share.share(
      'KUTS Announcement\n\n'
          '${announcement.title}\n\n'
          '${announcement.description}\n\n'
          'Audience: ${announcement.targetAudience}',
      subject: announcement.title,
    );
  } catch (e) {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to open sharing options.',
        ),
      ),
    );
  }
}

// ============================================================
// OPEN ATTACHMENT
// ============================================================

Future<void> openAnnouncementAttachment(
    BuildContext context,
    AnnouncementData announcement,
    ) async {
  final String? path =
      announcement.attachmentPath;

  if (path == null ||
      path.trim().isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Attachment file is not available.',
        ),
      ),
    );

    return;
  }

  final File file = File(path);

  if (!await file.exists()) {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'The attachment file could not be found.',
        ),
      ),
    );

    return;
  }

  try {
    final result =
    await OpenFilex.open(path);

    if (!context.mounted) {
      return;
    }

    if (result.type !=
        ResultType.done) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          backgroundColor:
          Colors.red,

          content: Text(
            result.message.isNotEmpty
                ? result.message
                : 'Unable to open this file.',
          ),
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Unable to open the attachment.',
        ),
      ),
    );
  }
}

// ============================================================
// DOWNLOAD ATTACHMENT
// ============================================================

Future<void> downloadAnnouncementAttachment(
    BuildContext context,
    AnnouncementData announcement,
    ) async {
  final String? sourcePath =
      announcement.attachmentPath;

  if (sourcePath == null ||
      sourcePath.trim().isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
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
    final File sourceFile =
    File(sourcePath);

    if (!await sourceFile.exists()) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'The attachment file could not be found.',
          ),
        ),
      );

      return;
    }

    Directory? downloadsDirectory;

    try {
      downloadsDirectory =
      await getDownloadsDirectory();
    } catch (_) {
      downloadsDirectory = null;
    }

    downloadsDirectory ??=
    await getApplicationDocumentsDirectory();

    String fileName =
        announcement.attachmentName ??
            sourceFile.path
                .split(
              Platform.pathSeparator,
            )
                .last;

    if (fileName.trim().isEmpty) {
      fileName =
      'KUTS_announcement_file';
    }

    File destinationFile = File(
      '${downloadsDirectory.path}'
          '${Platform.pathSeparator}'
          '$fileName',
    );

    if (await destinationFile
        .exists()) {
      final String baseName =
      fileName.contains('.')
          ? fileName.substring(
        0,
        fileName.lastIndexOf(
          '.',
        ),
      )
          : fileName;

      final String extension =
      fileName.contains('.')
          ? fileName.substring(
        fileName.lastIndexOf(
          '.',
        ),
      )
          : '';

      destinationFile = File(
        '${downloadsDirectory.path}'
            '${Platform.pathSeparator}'
            '${baseName}_${DateTime.now().millisecondsSinceEpoch}'
            '$extension',
      );
    }

    await sourceFile.copy(
      destinationFile.path,
    );

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor:
        const Color(0xff16a34a),

        content: Text(
          'Downloaded to ${downloadsDirectory.path}',
        ),

        action: SnackBarAction(
          label: 'OPEN',

          textColor: Colors.white,

          onPressed: () {
            OpenFilex.open(
              destinationFile.path,
            );
          },
        ),
      ),
    );
  } catch (e) {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Unable to download the attachment.',
        ),
      ),
    );
  }
}