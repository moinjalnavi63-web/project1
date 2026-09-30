import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

class _StudentProfileScreenState
    extends State<StudentProfileScreen> {
  File? _profilePhoto;

  final ImagePicker _imagePicker =
  ImagePicker();

  // ============================================================
  // CHANGE PROFILE PHOTO
  // ============================================================

  Future<void> _changeProfilePhoto() async {
    try {
      final XFile? selectedImage =
      await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (selectedImage == null) {
        return;
      }

      setState(() {
        _profilePhoto =
            File(selectedImage.path);
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to select profile photo.',
          ),
        ),
      );
    }
  }

  // ============================================================
  // PHOTO OPTIONS
  // ============================================================

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text(
                    'Profile Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Only your profile photo can be changed.',
                  ),
                ),

                const Divider(),

                // ------------------------------------------------
                // GALLERY
                // ------------------------------------------------

                ListTile(
                  leading:
                  const CircleAvatar(
                    child: Icon(
                      Icons
                          .photo_library_outlined,
                    ),
                  ),
                  title: const Text(
                    'Choose from Gallery',
                  ),
                  subtitle: const Text(
                    'Select a new profile photo',
                  ),
                  onTap: () async {
                    Navigator.pop(
                      sheetContext,
                    );

                    await _changeProfilePhoto();
                  },
                ),

                // ------------------------------------------------
                // REMOVE PHOTO
                // ------------------------------------------------

                if (_profilePhoto != null)
                  ListTile(
                    leading:
                    const CircleAvatar(
                      child: Icon(
                        Icons.delete_outline,
                      ),
                    ),
                    title: const Text(
                      'Remove Profile Photo',
                    ),
                    subtitle: const Text(
                      'Return to the default photo',
                    ),
                    onTap: () {
                      Navigator.pop(
                        sheetContext,
                      );

                      setState(() {
                        _profilePhoto =
                        null;
                      });
                    },
                  ),

                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // PROFILE PHOTO
  // ============================================================

  Widget _buildProfilePhoto() {
    return Center(
      child: Stack(
        clipBehavior:
        Clip.none,
        children: [
          Container(
            width: 112,
            height: 112,

            decoration:
            const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),

            padding:
            const EdgeInsets.all(4),

            child: ClipOval(
              child: _profilePhoto != null
                  ? Image.file(
                _profilePhoto!,
                width: 104,
                height: 104,
                fit: BoxFit.cover,
              )
                  : const CircleAvatar(
                backgroundColor:
                Color(0xFFEDE9FE),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color:
                  Color(0xFF5B5FEF),
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // CAMERA BUTTON
          // ------------------------------------------------------

          Positioned(
            right: -2,
            bottom: 0,

            child: Material(
              color:
              const Color(0xFF5B5FEF),

              shape:
              const CircleBorder(),

              elevation: 3,

              child: InkWell(
                customBorder:
                const CircleBorder(),

                onTap:
                _showPhotoOptions,

                child: const Padding(
                  padding:
                  EdgeInsets.all(10),

                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EDIT PHOTO BUTTON
  // ============================================================

  Widget _buildEditProfileButton() {
    return Center(
      child: TextButton.icon(
        onPressed:
        _showPhotoOptions,

        icon: const Icon(
          Icons.edit_outlined,
          size: 16,
        ),

        label: const Text(
          'Edit Profile Photo',
        ),

        style:
        TextButton.styleFrom(
          foregroundColor:
          const Color(
            0xFF5B5FEF,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration:
        const BoxDecoration(
          gradient: LinearGradient(
            begin:
            Alignment.topLeft,
            end:
            Alignment.bottomRight,

            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
          ),
        ),

        child: SafeArea(
          child:
          SingleChildScrollView(
            padding:
            const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // =================================================
                // PROFILE PHOTO
                // =================================================

                _buildProfilePhoto(),

                _buildEditProfileButton(),

                const SizedBox(
                  height: 20,
                ),

                // =================================================
                // ACADEMIC INFORMATION
                // =================================================

                const Text(
                  "Academic Information",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                const StudentInfoCard(),

                const SizedBox(
                  height: 25,
                ),

                // =================================================
                // TRANSPORT INFORMATION
                // =================================================

                const Text(
                  "Transport Information",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 12,
                ),

                const StudentBusCard(),

                const SizedBox(
                  height: 20,
                ),

                // =================================================
                // LIVE BUS ROUTE
                // =================================================

                const LiveBusRouteMap(
                  busNumber: 'Bus 01',
                  routeName:
                  'Hospet Route',
                  stops:
                  hospetRouteStops,
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}