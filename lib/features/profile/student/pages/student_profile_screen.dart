
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/student_profile_data.dart';
import '../widgets/student_profile_header.dart';
import '../widgets/student_info_card.dart';
import '../widgets/student_bus_card.dart';
import '../../../gps_tracking/widgets/live_bus_route_map.dart';
import '../../../gps_tracking/pages/hospet_route_data.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  File? _profilePhoto;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfilePhoto();
  }

  // Load the saved photo and synchronize shared profile data.
  Future<void> _loadProfilePhoto() async {
    await StudentProfilePhotoStorage.loadPhoto();

    if (!mounted) return;

    File? photo = studentProfilePhotoNotifier.value;

    if (photo == null || !await photo.exists()) {
      photo = null;
      studentProfilePhotoNotifier.value = null;
    }

    updateCurrentStudentProfilePhoto(photo?.path);

    if (!mounted) return;

    setState(() {
      _profilePhoto = photo;
    });
  }

  // Select and permanently save the profile photo.
  Future<void> _changeProfilePhoto() async {
    try {
      final XFile? selectedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (selectedImage == null) return;

      final File? savedFile =
      await StudentProfilePhotoStorage.savePhoto(
        selectedImage.path,
      );

      if (!mounted) return;

      if (savedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to save profile photo.'),
          ),
        );
        return;
      }

      updateCurrentStudentProfilePhoto(savedFile.path);

      setState(() {
        _profilePhoto = savedFile;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile photo updated successfully.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to select profile photo.'),
        ),
      );
    }
  }

  // Remove the photo from storage and shared profile data.
  Future<void> _removeProfilePhoto() async {
    updateCurrentStudentProfilePhoto(null);

    await StudentProfilePhotoStorage.removePhoto();

    if (!mounted) return;

    setState(() {
      _profilePhoto = null;
    });
  }

  // Show photo options.
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text(
                    'Profile Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Only your profile photo can be changed.',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.photo_library_outlined),
                  ),
                  title: const Text('Choose from Gallery'),
                  subtitle: const Text('Select a new profile photo'),
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _changeProfilePhoto();
                  },
                ),
                if (_profilePhoto != null)
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.delete_outline),
                    ),
                    title: const Text('Remove Profile Photo'),
                    subtitle: const Text(
                      'Return to the default photo',
                    ),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      await _removeProfilePhoto();
                    },
                  ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  // Profile photo without Center so it aligns correctly in the header row.
  Widget _buildProfilePhoto() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: ClipOval(
            child: _profilePhoto != null
                ? Image.file(
              _profilePhoto!,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _defaultAvatar();
              },
            )
                : _defaultAvatar(),
          ),
        ),
        Positioned(
          right: -2,
          bottom: 0,
          child: Material(
            color: const Color(0xFF5B5FEF),
            shape: const CircleBorder(),
            elevation: 3,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _showPhotoOptions,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _defaultAvatar() {
    return const CircleAvatar(
      backgroundColor: Color(0xFFEDE9FE),
      child: Icon(
        Icons.person,
        size: 52,
        color: Color(0xFF5B5FEF),
      ),
    );
  }

  // Top-left profile header: photo on the left, details on the right.
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfilePhoto(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentStudentProfile.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.school_outlined,
                      size: 17,
                      color: Color(0xFF5B5FEF),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        currentStudentProfile.department,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      size: 17,
                      color: Color(0xFF5B5FEF),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        currentStudentProfile.usn,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),

                const SizedBox(height: 28),

                const Text(
                  'Academic Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const StudentInfoCard(),

                const SizedBox(height: 25),

                const Text(
                  'Transport Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const StudentBusCard(),

                const SizedBox(height: 20),

                const LiveBusRouteMap(
                  busNumber: 'Bus 01',
                  routeName: 'Hospet Route',
                  stops: hospetRouteStops,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
