class LastRowSeat {
  final String id;
  final String name;
  final String usn;
  final String busId;
  final String tripDate;
  final String seatNumber;
  final bool isAllocated;
  final DateTime allocatedAt;

  const LastRowSeat({
    required this.id,
    required this.name,
    required this.usn,
    required this.busId,
    required this.tripDate,
    required this.seatNumber,
    required this.isAllocated,
    required this.allocatedAt,
  });

  LastRowSeat copyWith({
    String? id,
    String? name,
    String? usn,
    String? busId,
    String? tripDate,
    String? seatNumber,
    bool? isAllocated,
    DateTime? allocatedAt,
  }) {
    return LastRowSeat(
      id: id ?? this.id,
      name: name ?? this.name,
      usn: usn ?? this.usn,
      busId: busId ?? this.busId,
      tripDate: tripDate ?? this.tripDate,
      seatNumber: seatNumber ?? this.seatNumber,
      isAllocated: isAllocated ?? this.isAllocated,
      allocatedAt: allocatedAt ?? this.allocatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'usn': usn,
      'busId': busId,
      'tripDate': tripDate,
      'seatNumber': seatNumber,
      'isAllocated': isAllocated,
      'allocatedAt': allocatedAt.toIso8601String(),
    };
  }

  factory LastRowSeat.fromMap(
      Map<String, dynamic> map,
      ) {
    return LastRowSeat(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      usn: map['usn']?.toString() ?? '',
      busId: map['busId']?.toString() ?? '',
      tripDate: map['tripDate']?.toString() ?? '',
      seatNumber: map['seatNumber']?.toString() ?? '',
      isAllocated: map['isAllocated'] == true,
      allocatedAt:
      DateTime.tryParse(
        map['allocatedAt']?.toString() ?? '',
      ) ??
          DateTime.now(),
    );
  }
}