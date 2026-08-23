import '../models/token_model.dart';

class TokenService {
  // Temporary local storage.
  //
  // Later this will be replaced with your backend/database.
  final List<TokenModel> _tokens = [];

  // ==========================================================
  // GET ALL TOKENS
  // ==========================================================

  List<TokenModel> getAllTokens() {
    return List.unmodifiable(_tokens);
  }

  // ==========================================================
  // GET STUDENT'S TOKENS
  // Students should only receive their own tokens.
  // ==========================================================

  List<TokenModel> getStudentTokens(String studentId) {
    return _tokens
        .where((token) => token.studentId == studentId)
        .toList();
  }

  // ==========================================================
  // GET TOKEN BY TOKEN ID
  // ==========================================================

  TokenModel? getTokenById(String tokenId) {
    for (final token in _tokens) {
      if (token.tokenId == tokenId) {
        return token;
      }
    }

    return null;
  }

  // ==========================================================
  // CREATE TOKEN
  // ==========================================================

  TokenModel createToken({
    required String studentId,
    required String studentName,
    required String busNumber,
    required String pickupStop,
    required String issueCategory,
    required TokenPriority priority,
    required String description,
  }) {
    final now = DateTime.now();

    final token = TokenModel(
      tokenId: _generateTokenId(),
      studentId: studentId,
      studentName: studentName,
      busNumber: busNumber,
      pickupStop: pickupStop,
      issueCategory: issueCategory,
      priority: priority,
      description: description,
      status: TokenStatus.open,
      adminResponse: "",
      createdAt: now,
      updatedAt: now,
      resolvedAt: null,
    );

    _tokens.insert(0, token);

    return token;
  }

  // ==========================================================
  // UPDATE TOKEN
  // Used by ADMIN later.
  // ==========================================================

  TokenModel? updateToken({
    required String tokenId,
    TokenStatus? status,
    String? adminResponse,
  }) {
    final index = _tokens.indexWhere(
          (token) => token.tokenId == tokenId,
    );

    if (index == -1) {
      return null;
    }

    final oldToken = _tokens[index];

    final newStatus = status ?? oldToken.status;

    DateTime? resolvedAt = oldToken.resolvedAt;

    if (newStatus == TokenStatus.resolved) {
      resolvedAt = DateTime.now();
    }

    final updatedToken = oldToken.copyWith(
      status: newStatus,
      adminResponse:
      adminResponse ?? oldToken.adminResponse,
      updatedAt: DateTime.now(),
      resolvedAt: resolvedAt,
    );

    _tokens[index] = updatedToken;

    return updatedToken;
  }

  // ==========================================================
  // TOKEN ID GENERATOR
  // ==========================================================

  String _generateTokenId() {
    final nextNumber = _tokens.length + 1;

    return "#KUTS-2026-${nextNumber.toString().padLeft(5, '0')}";
  }

  // ==========================================================
  // TOKEN COUNT
  // ==========================================================

  int get totalTokens => _tokens.length;

  // ==========================================================
  // STUDENT TOKEN COUNTS
  // ==========================================================

  int getStudentTokenCount(String studentId) {
    return _tokens
        .where((token) => token.studentId == studentId)
        .length;
  }

  int getStudentOpenCount(String studentId) {
    return _tokens
        .where(
          (token) =>
      token.studentId == studentId &&
          token.status == TokenStatus.open,
    )
        .length;
  }

  int getStudentReviewingCount(String studentId) {
    return _tokens
        .where(
          (token) =>
      token.studentId == studentId &&
          token.status == TokenStatus.reviewing,
    )
        .length;
  }

  int getStudentResolvedCount(String studentId) {
    return _tokens
        .where(
          (token) =>
      token.studentId == studentId &&
          token.status == TokenStatus.resolved,
    )
        .length;
  }
}