class BuddyAllocationModel {
  final String allocationId;
  final String groupId;

  final String date;
  final String weekId;

  final List<String> studentIds;
  final List<String> studentNames;

  final List<String> seatNumbers;

  final bool together;

  final String allocationStatus;

  const BuddyAllocationModel({
    required this.allocationId,
    required this.groupId,
    required this.date,
    required this.weekId,
    required this.studentIds,
    required this.studentNames,
    required this.seatNumbers,
    required this.together,
    required this.allocationStatus,
  });

  // ==========================================================
  // STATUS CHECKS
  // ==========================================================

  bool get isAllocated {
    return allocationStatus.toLowerCase() == "allocated";
  }

  bool get isPending {
    return allocationStatus.toLowerCase() == "pending";
  }

  bool get isFailed {
    return allocationStatus.toLowerCase() == "failed";
  }

  bool get isCancelled {
    return allocationStatus.toLowerCase() == "cancelled";
  }

  // ==========================================================
  // STATUS TEXT
  // ==========================================================

  String get statusText {
    switch (allocationStatus.toLowerCase()) {
      case "allocated":
        return "Allocated";

      case "pending":
        return "Pending";

      case "failed":
        return "Failed";

      case "cancelled":
        return "Cancelled";

      default:
        return allocationStatus;
    }
  }

  // ==========================================================
  // TOGETHER TEXT
  // ==========================================================

  String get togetherText {
    return together ? "Together" : "Separate";
  }

  // ==========================================================
  // MEMBER COUNT
  // ==========================================================

  int get memberCount {
    return studentIds.length;
  }

  // ==========================================================
  // SEAT COUNT
  // ==========================================================

  int get seatCount {
    return seatNumbers.length;
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  BuddyAllocationModel copyWith({
    String? allocationId,
    String? groupId,
    String? date,
    String? weekId,
    List<String>? studentIds,
    List<String>? studentNames,
    List<String>? seatNumbers,
    bool? together,
    String? allocationStatus,
  }) {
    return BuddyAllocationModel(
      allocationId:
      allocationId ?? this.allocationId,
      groupId:
      groupId ?? this.groupId,
      date:
      date ?? this.date,
      weekId:
      weekId ?? this.weekId,
      studentIds:
      studentIds ?? this.studentIds,
      studentNames:
      studentNames ?? this.studentNames,
      seatNumbers:
      seatNumbers ?? this.seatNumbers,
      together:
      together ?? this.together,
      allocationStatus:
      allocationStatus ?? this.allocationStatus,
    );
  }

  // ==========================================================
  // MARK TOGETHER
  // ==========================================================

  BuddyAllocationModel markTogether({
    required List<String> seats,
  }) {
    return copyWith(
      seatNumbers: seats,
      together: true,
      allocationStatus: "allocated",
    );
  }

  // ==========================================================
  // MARK SEPARATE
  // ==========================================================

  BuddyAllocationModel markSeparate({
    required List<String> seats,
  }) {
    return copyWith(
      seatNumbers: seats,
      together: false,
      allocationStatus: "allocated",
    );
  }

  // ==========================================================
  // MARK FAILED
  // ==========================================================

  BuddyAllocationModel markFailed() {
    return copyWith(
      together: false,
      allocationStatus: "failed",
    );
  }

  // ==========================================================
  // JSON
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "allocationId": allocationId,
      "groupId": groupId,
      "date": date,
      "weekId": weekId,
      "studentIds": studentIds,
      "studentNames": studentNames,
      "seatNumbers": seatNumbers,
      "together": together,
      "allocationStatus": allocationStatus,
    };
  }

  // ==========================================================
  // FROM JSON
  // ==========================================================

  factory BuddyAllocationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return BuddyAllocationModel(
      allocationId:
      json["allocationId"] as String? ?? "",
      groupId:
      json["groupId"] as String? ?? "",
      date:
      json["date"] as String? ?? "",
      weekId:
      json["weekId"] as String? ?? "",
      studentIds:
      List<String>.from(
        json["studentIds"] ?? [],
      ),
      studentNames:
      List<String>.from(
        json["studentNames"] ?? [],
      ),
      seatNumbers:
      List<String>.from(
        json["seatNumbers"] ?? [],
      ),
      together:
      json["together"] as bool? ?? false,
      allocationStatus:
      json["allocationStatus"] as String? ??
          "pending",
    );
  }
}