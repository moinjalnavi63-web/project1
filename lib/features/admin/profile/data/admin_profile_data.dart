import 'dart:io';

import 'package:flutter/material.dart';

class AdminProfileData {
  final String name;
  final String email;
  final String mobile;
  final String role;
  final String? profilePhoto;

  const AdminProfileData({
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    this.profilePhoto,
  });

  // ============================================================
  // COPY WITH
  // ============================================================

  AdminProfileData copyWith({
    String? name,
    String? email,
    String? mobile,
    String? role,
    String? profilePhoto,
  }) {
    return AdminProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      role: role ?? this.role,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}

// ============================================================
// CURRENT ADMIN PROFILE
// ============================================================
//
// This is no longer const because the admin profile can be
// replaced after editing.
//
// ============================================================

AdminProfileData currentAdminProfile =
const AdminProfileData(
  name: 'Admin',
  email: 'admin@kuts.edu.in',
  mobile: '+91 9876543210',
  role: 'Transport Administrator',
  profilePhoto: null,
);

// ============================================================
// UPDATE CURRENT ADMIN PROFILE
// ============================================================

void updateCurrentAdminProfile({
  required String name,
  required String email,
  required String mobile,
  required String role,
  String? profilePhoto,
}) {
  currentAdminProfile =
      currentAdminProfile.copyWith(
        name: name,
        email: email,
        mobile: mobile,
        role: role,
        profilePhoto: profilePhoto,
      );
}

// ============================================================
// ADMIN PROFILE AVATAR
// ============================================================

class AdminProfileAvatar extends StatelessWidget {
  final double radius;

  const AdminProfileAvatar({
    super.key,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    final profile = currentAdminProfile;

    // ==========================================================
    // PROFILE PHOTO
    // ==========================================================

    if (profile.profilePhoto != null &&
        profile.profilePhoto!.trim().isNotEmpty) {
      final String photoPath =
      profile.profilePhoto!.trim();

      final File photoFile = File(photoPath);

      // ========================================================
      // LOCAL FILE PHOTO
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
      // ASSET PHOTO
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
        ? profile.name.trim()[0].toUpperCase()
        : 'A';

    return CircleAvatar(
      radius: radius,
      backgroundColor:
      const Color(0xffede9fe),
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: radius * 0.75,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}