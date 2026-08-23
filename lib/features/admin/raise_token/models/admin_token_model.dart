enum AdminTokenCategory {
  busRoute,
  seat,
  buddySystem,
  attendance,
  app,
  emergency,
}

extension AdminTokenCategoryExtension on AdminTokenCategory {
  String get title {
    switch (this) {
      case AdminTokenCategory.busRoute:
        return 'Bus / Route';

      case AdminTokenCategory.seat:
        return 'Seat';

      case AdminTokenCategory.buddySystem:
        return 'Buddy System';

      case AdminTokenCategory.attendance:
        return 'Attendance';

      case AdminTokenCategory.app:
        return 'Token / App';

      case AdminTokenCategory.emergency:
        return 'Emergency / Other';
    }
  }
}

enum AdminTokenStatus {
  pending,
  inProgress,
  resolved,
  rejected,
}

extension AdminTokenStatusExtension on AdminTokenStatus {
  String get title {
    switch (this) {
      case AdminTokenStatus.pending:
        return 'Pending';

      case AdminTokenStatus.inProgress:
        return 'In Progress';

      case AdminTokenStatus.resolved:
        return 'Resolved';

      case AdminTokenStatus.rejected:
        return 'Rejected';
    }
  }
}

class AdminTokenModel {
  final String tokenId;

  final AdminTokenCategory category;

  final String issueType;

  final AdminTokenStatus status;

  final String studentName;
  final String studentUsn;

  final String? profilePhoto;

  final String email;
  final String mobile;

  final String busNumber;
  final String route;
  final String pickupStop;
  final String? seatNumber;

  final String description;

  final String? attachmentPath;

  final DateTime createdAt;
  final DateTime? updatedAt;

  final String? adminResponse;

  const AdminTokenModel({
    required this.tokenId,
    required this.category,
    required this.issueType,
    required this.status,
    required this.studentName,
    required this.studentUsn,
    this.profilePhoto,
    required this.email,
    required this.mobile,
    required this.busNumber,
    required this.route,
    required this.pickupStop,
    this.seatNumber,
    required this.description,
    this.attachmentPath,
    required this.createdAt,
    this.updatedAt,
    this.adminResponse,
  });

  AdminTokenModel copyWith({
    AdminTokenStatus? status,
    String? adminResponse,
    DateTime? updatedAt,
  }) {
    return AdminTokenModel(
      tokenId: tokenId,
      category: category,
      issueType: issueType,
      status: status ?? this.status,
      studentName: studentName,
      studentUsn: studentUsn,
      profilePhoto: profilePhoto,
      email: email,
      mobile: mobile,
      busNumber: busNumber,
      route: route,
      pickupStop: pickupStop,
      seatNumber: seatNumber,
      description: description,
      attachmentPath: attachmentPath,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      adminResponse: adminResponse ?? this.adminResponse,
    );
  }
}