class BuddyGroupModel {
  final String groupId;
  final String leaderId;
  final String leaderName;

  final String busNumber;

  final List<String> memberIds;
  final List<String> memberNames;

  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;

  const BuddyGroupModel({
    required this.groupId,
    required this.leaderId,
    required this.leaderName,
    required this.busNumber,
    required this.memberIds,
    required this.memberNames,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // ==========================================================
  // GROUP SIZE
  // ==========================================================

  int get groupSize {
    return memberIds.length;
  }

  // ==========================================================
  // ACTIVE GROUP
  // ==========================================================

  bool get isActive {
    return status.toLowerCase() == "active";
  }

  // ==========================================================
  // GROUP SIZE VALIDATION
  // ==========================================================

  bool get canAddMember {
    return memberIds.length < 3;
  }

  bool get hasMinimumMembers {
    return memberIds.length >= 2;
  }

  bool get isFull {
    return memberIds.length >= 3;
  }

  // ==========================================================
  // STATUS TEXT
  // ==========================================================

  String get statusText {
    switch (status.toLowerCase()) {
      case "active":
        return "Active";

      case "inactive":
        return "Inactive";

      case "closed":
        return "Closed";

      default:
        return status;
    }
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  BuddyGroupModel copyWith({
    String? groupId,
    String? leaderId,
    String? leaderName,
    String? busNumber,
    List<String>? memberIds,
    List<String>? memberNames,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BuddyGroupModel(
      groupId: groupId ?? this.groupId,
      leaderId: leaderId ?? this.leaderId,
      leaderName: leaderName ?? this.leaderName,
      busNumber: busNumber ?? this.busNumber,
      memberIds: memberIds ?? this.memberIds,
      memberNames: memberNames ?? this.memberNames,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ==========================================================
  // ADD MEMBER
  // ==========================================================

  BuddyGroupModel addMember({
    required String memberId,
    required String memberName,
  }) {
    if (isFull) {
      return this;
    }

    if (memberIds.contains(memberId)) {
      return this;
    }

    return copyWith(
      memberIds: [
        ...memberIds,
        memberId,
      ],
      memberNames: [
        ...memberNames,
        memberName,
      ],
      updatedAt: DateTime.now(),
    );
  }

  // ==========================================================
  // REMOVE MEMBER
  // ==========================================================

  BuddyGroupModel removeMember(
      String memberId,
      ) {
    final index = memberIds.indexOf(memberId);

    if (index == -1) {
      return this;
    }

    final updatedIds = [
      ...memberIds,
    ];

    final updatedNames = [
      ...memberNames,
    ];

    updatedIds.removeAt(index);

    if (index < updatedNames.length) {
      updatedNames.removeAt(index);
    }

    return copyWith(
      memberIds: updatedIds,
      memberNames: updatedNames,
      updatedAt: DateTime.now(),
    );
  }

  // ==========================================================
  // LEADER CHECK
  // ==========================================================

  bool isLeader(String studentId) {
    return leaderId == studentId;
  }

  // ==========================================================
  // JSON
  // Frontend only for now.
  // Useful later when backend/database is connected.
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "leaderId": leaderId,
      "leaderName": leaderName,
      "busNumber": busNumber,
      "memberIds": memberIds,
      "memberNames": memberNames,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  // ==========================================================
  // FROM JSON
  // ==========================================================

  factory BuddyGroupModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return BuddyGroupModel(
      groupId: json["groupId"] as String? ?? "",
      leaderId: json["leaderId"] as String? ?? "",
      leaderName: json["leaderName"] as String? ?? "",
      busNumber: json["busNumber"] as String? ?? "",
      memberIds: List<String>.from(
        json["memberIds"] ?? [],
      ),
      memberNames: List<String>.from(
        json["memberNames"] ?? [],
      ),
      status: json["status"] as String? ?? "active",
      createdAt:
      DateTime.tryParse(
        json["createdAt"] as String? ?? "",
      ) ??
          DateTime.now(),
      updatedAt:
      DateTime.tryParse(
        json["updatedAt"] as String? ?? "",
      ) ??
          DateTime.now(),
    );
  }
}