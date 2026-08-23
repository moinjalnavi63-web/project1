class BuddyMemberModel {
  final String memberId;
  final String groupId;

  final String studentId;
  final String studentName;

  final String busNumber;

  final String status;

  final bool accepted;
  final bool active;

  final bool isLeader;

  final DateTime joinedAt;

  const BuddyMemberModel({
    required this.memberId,
    required this.groupId,
    required this.studentId,
    required this.studentName,
    required this.busNumber,
    required this.status,
    required this.accepted,
    required this.active,
    required this.isLeader,
    required this.joinedAt,
  });

  // ==========================================================
  // STATUS CHECKS
  // ==========================================================

  bool get isPending {
    return status.toLowerCase() == "pending";
  }

  bool get isConfirmed {
    return status.toLowerCase() == "confirmed";
  }

  bool get isDeclined {
    return status.toLowerCase() == "declined";
  }

  bool get hasLeft {
    return status.toLowerCase() == "left";
  }

  bool get isRemoved {
    return status.toLowerCase() == "removed";
  }

  bool get isInactive {
    return status.toLowerCase() == "inactive";
  }

  // ==========================================================
  // STATUS TEXT
  // ==========================================================

  String get statusText {
    switch (status.toLowerCase()) {
      case "pending":
        return "Pending";

      case "confirmed":
        return "Confirmed";

      case "declined":
        return "Declined";

      case "left":
        return "Left";

      case "removed":
        return "Removed";

      case "inactive":
        return "Inactive";

      default:
        return status;
    }
  }

  // ==========================================================
  // DISPLAY ROLE
  // ==========================================================

  String get roleText {
    return isLeader ? "Leader" : "Member";
  }

  // ==========================================================
  // ACTIVE CONFIRMED MEMBER
  // ==========================================================

  bool get isActiveConfirmed {
    return active &&
        accepted &&
        isConfirmed;
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  BuddyMemberModel copyWith({
    String? memberId,
    String? groupId,
    String? studentId,
    String? studentName,
    String? busNumber,
    String? status,
    bool? accepted,
    bool? active,
    bool? isLeader,
    DateTime? joinedAt,
  }) {
    return BuddyMemberModel(
      memberId: memberId ?? this.memberId,
      groupId: groupId ?? this.groupId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      busNumber: busNumber ?? this.busNumber,
      status: status ?? this.status,
      accepted: accepted ?? this.accepted,
      active: active ?? this.active,
      isLeader: isLeader ?? this.isLeader,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  // ==========================================================
  // ACCEPT REQUEST
  // ==========================================================

  BuddyMemberModel acceptRequest() {
    return copyWith(
      accepted: true,
      active: true,
      status: "confirmed",
    );
  }

  // ==========================================================
  // DECLINE REQUEST
  // ==========================================================

  BuddyMemberModel declineRequest() {
    return copyWith(
      accepted: false,
      active: false,
      status: "declined",
    );
  }

  // ==========================================================
  // LEAVE GROUP
  // ==========================================================

  BuddyMemberModel leaveGroup() {
    return copyWith(
      active: false,
      status: "left",
    );
  }

  // ==========================================================
  // REMOVE MEMBER
  // ==========================================================

  BuddyMemberModel removeFromGroup() {
    return copyWith(
      active: false,
      status: "removed",
    );
  }

  // ==========================================================
  // TRANSFER LEADERSHIP
  // ==========================================================

  BuddyMemberModel makeLeader() {
    return copyWith(
      isLeader: true,
    );
  }

  BuddyMemberModel removeLeadership() {
    return copyWith(
      isLeader: false,
    );
  }

  // ==========================================================
  // JSON
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "memberId": memberId,
      "groupId": groupId,
      "studentId": studentId,
      "studentName": studentName,
      "busNumber": busNumber,
      "status": status,
      "accepted": accepted,
      "active": active,
      "isLeader": isLeader,
      "joinedAt": joinedAt.toIso8601String(),
    };
  }

  // ==========================================================
  // FROM JSON
  // ==========================================================

  factory BuddyMemberModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return BuddyMemberModel(
      memberId: json["memberId"] as String? ?? "",
      groupId: json["groupId"] as String? ?? "",
      studentId: json["studentId"] as String? ?? "",
      studentName: json["studentName"] as String? ?? "",
      busNumber: json["busNumber"] as String? ?? "",
      status: json["status"] as String? ?? "pending",
      accepted: json["accepted"] as bool? ?? false,
      active: json["active"] as bool? ?? true,
      isLeader: json["isLeader"] as bool? ?? false,
      joinedAt:
      DateTime.tryParse(
        json["joinedAt"] as String? ?? "",
      ) ??
          DateTime.now(),
    );
  }
}