import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FacultyProfileScreen
    extends StatefulWidget {
  const FacultyProfileScreen({
    super.key,
  });

  @override
  State<FacultyProfileScreen>
  createState() =>
      _FacultyProfileScreenState();
}

class _FacultyProfileScreenState
    extends State<FacultyProfileScreen> {
  File? _profilePhoto;

  final ImagePicker _imagePicker =
  ImagePicker();

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

  Widget _buildProfilePhoto() {
    return Stack(
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
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,

      margin:
      const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
        Colors.white.withOpacity(.90),

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(
              .06,
            ),
            blurRadius: 12,
            offset:
            const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,

            decoration:
            BoxDecoration(
              color:
              const Color(0xFFEDE9FE),

              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(
              icon,
              color:
              const Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Text(
                  title,

                  style:
                  const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  value,

                  style:
                  const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                  ),
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
    return Container(
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
              // ------------------------------------------------
              // PROFILE PHOTO
              // ------------------------------------------------

              Center(
                child: Column(
                  children: [
                    _buildProfilePhoto(),

                    const SizedBox(
                      height: 15,
                    ),

                    // ------------------------------------------------
                    // EXISTING FACULTY DATA
                    // ------------------------------------------------

                    const Text(
                      "Faculty Name",

                      style:
                      TextStyle(
                        fontSize: 25,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const Text(
                      "Faculty ID",

                      style:
                      TextStyle(
                        fontSize: 16,
                        color:
                        Colors.grey,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    TextButton.icon(
                      onPressed:
                      _showPhotoOptions,
                      icon:
                      const Icon(
                        Icons
                            .edit_outlined,
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
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // ------------------------------------------------
              // EXISTING FACULTY INFORMATION
              // ------------------------------------------------

              _infoCard(
                icon:
                Icons.person_outline,
                title: "Full Name",
                value: "Faculty Name",
              ),

              _infoCard(
                icon:
                Icons.badge_outlined,
                title: "Faculty ID",
                value: "Faculty ID",
              ),

              _infoCard(
                icon:
                Icons.email_outlined,
                title: "Email",
                value:
                "faculty@gmail.com",
              ),
            ],
          ),
        ),
      ),
    );
  }
}