import '../models/admin_token_model.dart';

class AdminTokenData {
  static final List<AdminTokenModel> tokens = [
    AdminTokenModel(
      tokenId: 'KT-001',
      category: AdminTokenCategory.seat,
      issueType: 'Wrong Seat Allocation',
      status: AdminTokenStatus.pending,
      studentName: 'Moin',
      studentUsn: 'KUB24CSE118',
      email: 'moin@example.com',
      mobile: '9876543210',
      busNumber: 'Bus 1',
      route: 'Hospet → Kishkinda University',
      pickupStop: 'Hospet',
      seatNumber: '7A',
      description:
      'My seat allocation is different from the seat shown earlier.',
      createdAt: DateTime(
        2026,
        8,
        5,
        8,
        45,
      ),
    ),

    AdminTokenModel(
      tokenId: 'KT-002',
      category: AdminTokenCategory.busRoute,
      issueType: 'Timing Problem',
      status: AdminTokenStatus.inProgress,
      studentName: 'Mohammed Mansoor',
      studentUsn: 'KUB24CSE119',
      email: 'mansoor@example.com',
      mobile: '9876543211',
      busNumber: 'Bus 1',
      route: 'Hospet → Kishkinda University',
      pickupStop: 'Hospet',
      seatNumber: '7B',
      description:
      'The bus is arriving late at the pickup stop.',
      createdAt: DateTime(
        2026,
        8,
        5,
        9,
        10,
      ),
      adminResponse:
      'The issue has been forwarded to the transport team.',
    ),

    AdminTokenModel(
      tokenId: 'KT-003',
      category: AdminTokenCategory.buddySystem,
      issueType: 'Buddy Seat Problem',
      status: AdminTokenStatus.pending,
      studentName: 'Rahul Kumar',
      studentUsn: 'KUB25ECE101',
      email: 'rahul@example.com',
      mobile: '9876543212',
      busNumber: 'Bus 2',
      route: 'Gangavathi → Kishkinda University',
      pickupStop: 'Gangavathi',
      seatNumber: '8A',
      description:
      'My buddy group was created but the seats are not together.',
      createdAt: DateTime(
        2026,
        8,
        5,
        9,
        30,
      ),
    ),

    AdminTokenModel(
      tokenId: 'KT-004',
      category: AdminTokenCategory.attendance,
      issueType: 'Attendance Not Marked',
      status: AdminTokenStatus.resolved,
      studentName: 'Anjali',
      studentUsn: 'KUB25ISE104',
      email: 'anjali@example.com',
      mobile: '9876543213',
      busNumber: 'Bus 2',
      route: 'Gangavathi → Kishkinda University',
      pickupStop: 'Gangavathi',
      seatNumber: '8B',
      description:
      'I confirmed attendance but it is showing as absent.',
      createdAt: DateTime(
        2026,
        8,
        5,
        7,
        50,
      ),
      adminResponse:
      'Attendance has been corrected.',
    ),

    AdminTokenModel(
      tokenId: 'KT-005',
      category: AdminTokenCategory.app,
      issueType: 'Notification Problem',
      status: AdminTokenStatus.pending,
      studentName: 'Arun',
      studentUsn: 'KUB26AIML110',
      email: 'arun@example.com',
      mobile: '9876543214',
      busNumber: 'Bus 3',
      route: 'Koppal → Kishkinda University',
      pickupStop: 'Koppal',
      seatNumber: '9A',
      description:
      'I am not receiving transport notifications.',
      createdAt: DateTime(
        2026,
        8,
        5,
        10,
        5,
      ),
    ),

    AdminTokenModel(
      tokenId: 'KT-006',
      category: AdminTokenCategory.seat,
      issueType: 'Damaged Seat',
      status: AdminTokenStatus.rejected,
      studentName: 'Priya',
      studentUsn: 'KUB24CSE125',
      email: 'priya@example.com',
      mobile: '9876543215',
      busNumber: 'Bus 4',
      route: 'Hospet → Kishkinda University',
      pickupStop: 'Hospet',
      seatNumber: '10C',
      description:
      'The seat appears damaged.',
      createdAt: DateTime(
        2026,
        8,
        4,
        11,
        20,
      ),
      adminResponse:
      'The reported issue could not be verified.',
    ),

    AdminTokenModel(
      tokenId: 'KT-007',
      category: AdminTokenCategory.emergency,
      issueType: 'Emergency Transport Issue',
      status: AdminTokenStatus.inProgress,
      studentName: 'Vikas',
      studentUsn: 'KUB25MECH115',
      email: 'vikas@example.com',
      mobile: '9876543216',
      busNumber: 'Bus 5',
      route: 'Hospet → Kishkinda University',
      pickupStop: 'Hospet',
      seatNumber: '11A',
      description:
      'Urgent transport-related issue reported.',
      createdAt: DateTime(
        2026,
        8,
        5,
        10,
        40,
      ),
    ),
  ];

  static List<AdminTokenModel> getAllTokens() {
    return List.unmodifiable(tokens);
  }
}