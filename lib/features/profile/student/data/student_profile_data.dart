
import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/student_profile_header.dart';

// ============================================================
// STUDENT PROFILE DATA
// ============================================================

class StudentProfileData {
  final String name;
  final String usn;
  final String department;
  final String admissionYear;
  final String currentYear;
  final String busNumber;
  final String route;
  final String? profilePhoto;

  const StudentProfileData({
    required this.name,
    required this.usn,
    required this.department,
    required this.admissionYear,
    required this.currentYear,
    required this.busNumber,
    required this.route,
    this.profilePhoto,
  });

  StudentProfileData copyWith({
    String? name,
    String? usn,
    String? department,
    String? admissionYear,
    String? currentYear,
    String? busNumber,
    String? route,
    String? profilePhoto,
  }) {
    return StudentProfileData(
      name: name ?? this.name,
      usn: usn ?? this.usn,
      department: department ?? this.department,
      admissionYear: admissionYear ?? this.admissionYear,
      currentYear: currentYear ?? this.currentYear,
      busNumber: busNumber ?? this.busNumber,
      route: route ?? this.route,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}

// ============================================================
// CURRENT STUDENT PROFILE
// Existing student data preserved.
// ============================================================

StudentProfileData currentStudentProfile =
const StudentProfileData(
  name: 'Mohammed Moinuddin',
  usn: 'KUB24CSE118',
  department: 'CSE',
  admissionYear: '2024',
  currentYear: '3rd Year',
  busNumber: 'Bus 01',
  route: 'Hospet Route',
  profilePhoto: null,
);

// ============================================================
// UPDATE STUDENT PROFILE PHOTO
// Only the profile photo can be changed.
// ============================================================

void updateCurrentStudentProfilePhoto(String? profilePhoto) {
  currentStudentProfile = StudentProfileData(
    name: currentStudentProfile.name,
    usn: currentStudentProfile.usn,
    department: currentStudentProfile.department,
    admissionYear: currentStudentProfile.admissionYear,
    currentYear: currentStudentProfile.currentYear,
    busNumber: currentStudentProfile.busNumber,
    route: currentStudentProfile.route,
    profilePhoto: profilePhoto,
  );
}

// ============================================================
// STUDENT PROFILE AVATAR
// Shared with the student drawer.
// Rebuilds automatically when the photo notifier changes.
// ============================================================

class StudentProfileAvatar extends StatelessWidget {
  final double radius;

  const StudentProfileAvatar({
    super.key,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: studentProfilePhotoNotifier,
      builder: (context, savedPhoto, child) {
        final profile = currentStudentProfile;

        // Prefer the permanently saved photo.
        if (savedPhoto != null && savedPhoto.existsSync()) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: const Color(0xffede9fe),
            backgroundImage: FileImage(savedPhoto),
          );
        }

        // Fall back to the photo path stored in profile data.
        final String? photoPath = profile.profilePhoto;

        if (photoPath != null && photoPath.trim().isNotEmpty) {
          final String path = photoPath.trim();
          final File photoFile = File(path);

          if (photoFile.existsSync()) {
            return CircleAvatar(
              radius: radius,
              backgroundColor: const Color(0xffede9fe),
              backgroundImage: FileImage(photoFile),
            );
          }

          // Preserve support for existing asset images.
          if (!path.contains(Platform.pathSeparator) &&
              !path.contains(':')) {
            return CircleAvatar(
              radius: radius,
              backgroundColor: const Color(0xffede9fe),
              backgroundImage: AssetImage(path),
            );
          }
        }

        // Default avatar when no photo is available.
        final String firstLetter =
        profile.name.trim().isNotEmpty
            ? profile.name.trim()[0].toUpperCase()
            : 'S';

        return CircleAvatar(
          radius: radius,
          backgroundColor: const Color(0xffede9fe),
          child: Text(
            firstLetter,
            style: TextStyle(
              fontSize: radius * 0.75,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }
}
