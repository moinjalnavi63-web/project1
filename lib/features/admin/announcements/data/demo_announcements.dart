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

  const AnnouncementData({
    required this.title,
    required this.description,
    required this.type,
    required this.targetAudience,
    required this.dateTime,
    this.attachmentName,
    this.attachmentPath,
    this.attachmentType,
  });

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