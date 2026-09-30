import 'dart:io';

import 'package:flutter/material.dart';

// ============================================================
// STUDENT PROFILE DATA
// ============================================================
//
// Student profile information.
//
// IMPORTANT:
// Only profilePhoto is changeable by the student.
// All other information remains view-only.
//

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

  // ============================================================
  // COPY WITH
  // ============================================================

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
// ============================================================
//
// Keep your existing student data here.
//
// Only profilePhoto is updated when the student changes
// their profile picture.
//

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
// ============================================================
//
// IMPORTANT:
// Student is NOT allowed to change name, USN, department,
// admission year, current year, bus number or route.
//
// Only the profile photo is updated.
//

void updateCurrentStudentProfilePhoto(
    String? profilePhoto,
    ) {
  currentStudentProfile =
      StudentProfileData(
        name: currentStudentProfile.name,
        usn: currentStudentProfile.usn,
        department: currentStudentProfile.department,
        admissionYear:
        currentStudentProfile.admissionYear,
        currentYear:
        currentStudentProfile.currentYear,
        busNumber:
        currentStudentProfile.busNumber,
        route:
        currentStudentProfile.route,
        profilePhoto: profilePhoto,
      );
}

// ============================================================
// STUDENT PROFILE AVATAR
// ============================================================
//
// This widget is used by the Student Drawer.
//
// If the student has uploaded a photo, the photo is displayed.
// Otherwise, the default student avatar is displayed.
//

class StudentProfileAvatar extends StatelessWidget {
  final double radius;

  const StudentProfileAvatar({
    super.key,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final profile =
        currentStudentProfile;

    // ==========================================================
    // PROFILE PHOTO
    // ==========================================================

    if (profile.profilePhoto != null &&
        profile.profilePhoto!.trim().isNotEmpty) {
      final String photoPath =
      profile.profilePhoto!.trim();

      final File photoFile =
      File(photoPath);

      // ========================================================
      // LOCAL IMAGE
      // ========================================================

      if (photoFile.existsSync()) {
        return CircleAvatar(
          radius: radius,
          backgroundColor:
          const Color(0xffede9fe),
          backgroundImage:
          FileImage(photoFile),
        );
      }

      // ========================================================
      // ASSET IMAGE
      // ========================================================

      return CircleAvatar(
        radius: radius,
        backgroundColor:
        const Color(0xffede9fe),
        backgroundImage:
        AssetImage(photoPath),
      );
    }

    // ==========================================================
    // DEFAULT LETTER AVATAR
    // ==========================================================

    final String firstLetter =
    profile.name.trim().isNotEmpty
        ? profile.name
        .trim()[0]
        .toUpperCase()
        : 'S';

    return CircleAvatar(
      radius: radius,
      backgroundColor:
      const Color(0xffede9fe),
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize:
          radius * 0.75,
          fontWeight:
          FontWeight.bold,
          color:
          Colors.deepPurple,
        ),
      ),
    );
  }
}