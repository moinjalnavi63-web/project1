enum AdminSeatZone {
  faculty,
  girls,
  boys,
}

class AdminSeatModel {
  final String seatId;
  final AdminSeatZone zone;

  final bool isOccupied;
  final bool isBuddySeat;

  final String busNumber;

  final String? studentName;
  final String? studentUsn;
  final String? branch;
  final String? year;
  final String? pickupStop;

  final String? buddyGroupName;

  const AdminSeatModel({
    required this.seatId,
    required this.zone,
    required this.isOccupied,
    required this.isBuddySeat,
    required this.busNumber,
    this.studentName,
    this.studentUsn,
    this.branch,
    this.year,
    this.pickupStop,
    this.buddyGroupName,
  });
}