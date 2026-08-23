import '../models/token_model.dart';

final List<TokenModel> demoTokens = [
  TokenModel(
    tokenId: "#KUTS-2026-00125",
    studentId: "KUB24CSE118",
    studentName: "Mohammed Moinuddin",
    busNumber: "Bus 01",
    pickupStop: "Hospet",
    issueCategory: "Late Bus",
    priority: TokenPriority.high,
    description:
    "The bus has not arrived at the pickup point even after the scheduled time.",
    status: TokenStatus.reviewing,
    adminResponse:
    "We have informed the transport coordinator and are checking the bus location.",
    createdAt: DateTime(2026, 7, 30, 8, 45),
    updatedAt: DateTime(2026, 7, 30, 9, 5),
  ),

  TokenModel(
    tokenId: "#KUTS-2026-00124",
    studentId: "KUB24CSE101",
    studentName: "Ayesha",
    busNumber: "Bus 02",
    pickupStop: "Gandhinagar",
    issueCategory: "Overcrowded",
    priority: TokenPriority.medium,
    description:
    "The bus is overcrowded and there is not enough space for students.",
    status: TokenStatus.open,
    adminResponse: "",
    createdAt: DateTime(2026, 7, 29, 8, 20),
    updatedAt: DateTime(2026, 7, 29, 8, 20),
  ),

  TokenModel(
    tokenId: "#KUTS-2026-00123",
    studentId: "KUB24CSE126",
    studentName: "Rahul",
    busNumber: "Bus 01",
    pickupStop: "Koppal",
    issueCategory: "Route Issue",
    priority: TokenPriority.low,
    description:
    "The bus did not follow the regular route and skipped the expected stop.",
    status: TokenStatus.resolved,
    adminResponse:
    "The route issue has been checked and the driver has been informed.",
    createdAt: DateTime(2026, 7, 28, 7, 55),
    updatedAt: DateTime(2026, 7, 28, 10, 15),
    resolvedAt: DateTime(2026, 7, 28, 10, 15),
  ),
];