class StudentDirectoryModel {
  final String name;
  final String usn;
  final String year;
  final String branch;
  final String busNumber;
  final String pickupStop;

  // Frontend-only for now.
  // Later this should come from the existing
  // Registration/Profile data.
  final String? profilePhoto;

  const StudentDirectoryModel({
    required this.name,
    required this.usn,
    required this.year,
    required this.branch,
    required this.busNumber,
    required this.pickupStop,
    this.profilePhoto,
  });

  StudentDirectoryModel copyWith({
    String? name,
    String? usn,
    String? year,
    String? branch,
    String? busNumber,
    String? pickupStop,
    String? profilePhoto,
  }) {
    return StudentDirectoryModel(
      name: name ?? this.name,
      usn: usn ?? this.usn,
      year: year ?? this.year,
      branch: branch ?? this.branch,
      busNumber: busNumber ?? this.busNumber,
      pickupStop: pickupStop ?? this.pickupStop,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  factory StudentDirectoryModel.fromRegistration({
    required String name,
    required String usn,
    required String year,
    required String branch,
    required String busNumber,
    required String pickupStop,
    String? profilePhoto,
  }) {
    return StudentDirectoryModel(
      name: name,
      usn: usn,
      year: year,
      branch: branch,
      busNumber: busNumber,
      pickupStop: pickupStop,
      profilePhoto: profilePhoto,
    );
  }

  String get academicInfo {
    return "$year • $branch";
  }

  String get busInfo {
    return "Bus $busNumber";
  }

  String get stopInfo {
    return pickupStop;
  }
}