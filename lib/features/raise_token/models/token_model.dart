enum TokenStatus {
  open,
  reviewing,
  resolved,
}

enum TokenPriority {
  low,
  medium,
  high,
}

class TokenModel {
  final String tokenId;

  final String studentId;
  final String studentName;

  final String busNumber;
  final String pickupStop;

  final String issueCategory;
  final TokenPriority priority;

  final String description;

  final TokenStatus status;

  final String adminResponse;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  const TokenModel({
    required this.tokenId,
    required this.studentId,
    required this.studentName,
    required this.busNumber,
    required this.pickupStop,
    required this.issueCategory,
    required this.priority,
    required this.description,
    required this.status,
    required this.adminResponse,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  // ==========================================================
  // COPY WITH
  // Used later when admin changes the token status/response.
  // ==========================================================

  TokenModel copyWith({
    String? tokenId,
    String? studentId,
    String? studentName,
    String? busNumber,
    String? pickupStop,
    String? issueCategory,
    TokenPriority? priority,
    String? description,
    TokenStatus? status,
    String? adminResponse,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) {
    return TokenModel(
      tokenId: tokenId ?? this.tokenId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      busNumber: busNumber ?? this.busNumber,
      pickupStop: pickupStop ?? this.pickupStop,
      issueCategory: issueCategory ?? this.issueCategory,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      status: status ?? this.status,
      adminResponse:
      adminResponse ?? this.adminResponse,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  // ==========================================================
  // STATUS TEXT
  // ==========================================================

  String get statusText {
    switch (status) {
      case TokenStatus.open:
        return "Open";

      case TokenStatus.reviewing:
        return "Reviewing";

      case TokenStatus.resolved:
        return "Resolved";
    }
  }

  // ==========================================================
  // PRIORITY TEXT
  // ==========================================================

  String get priorityText {
    switch (priority) {
      case TokenPriority.low:
        return "Low";

      case TokenPriority.medium:
        return "Medium";

      case TokenPriority.high:
        return "High";
    }
  }
}