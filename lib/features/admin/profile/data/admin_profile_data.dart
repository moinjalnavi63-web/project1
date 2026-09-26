import 'package:flutter/material.dart';

// ============================================================
// ADMIN PROFILE DATA
// ============================================================
//
// This is the central admin profile information.
//
// Later this can be connected to Firebase / Supabase / MySQL.
// For now it works as frontend stored profile data just like
// the existing student profile data.
//
// ============================================================

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
}


// ============================================================
// CURRENT ADMIN PROFILE
// ============================================================
//
// Change these values with the actual admin information.
//
// profilePhoto:
// - Keep null if there is no photo.
// - If using an asset, example:
//   'assets/images/admin_profile.jpg'
//
// ============================================================

const AdminProfileData currentAdminProfile = AdminProfileData(
  name: 'KUTS Admin',
  email: 'admin@kuts.edu.in',
  mobile: '+91 9876543210',
  role: 'Transport Administrator',
  profilePhoto: null,
);


// ============================================================
// ADMIN AVATAR
// ============================================================
//
// Reusable widget for displaying the admin photo.
//
// If profilePhoto is null, it automatically displays the first
// letter of the admin name.
//
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

    // ========================================================
    // PROFILE PHOTO AVAILABLE
    // ========================================================

    if (profile.profilePhoto != null &&
        profile.profilePhoto!.trim().isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(
          profile.profilePhoto!,
        ),
        backgroundColor: const Color(0xffede9fe),
      );
    }

    // ========================================================
    // NO PHOTO
    // ========================================================

    final String firstLetter =
    profile.name.trim().isNotEmpty
        ? profile.name.trim()[0].toUpperCase()
        : 'A';

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
  }
}