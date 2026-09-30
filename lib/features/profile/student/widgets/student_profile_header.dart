import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// ============================================================
// SHARED STUDENT PROFILE PHOTO
// ============================================================
//
// This notifier is shared by:
//
// 1. Student Profile
// 2. Student Drawer
//
// Therefore both places always display the same photo.
// ============================================================

final ValueNotifier<File?> studentProfilePhotoNotifier =
ValueNotifier<File?>(null);


// ============================================================
// STUDENT PROFILE PHOTO STORAGE
// ============================================================

class StudentProfilePhotoStorage {
  static const String _fileName =
      'student_profile_photo.jpg';

  // ==========================================================
  // GET PERMANENT PHOTO FILE
  // ==========================================================

  static Future<File> _photoFile() async {
    final Directory directory =
    await getApplicationDocumentsDirectory();

    return File(
      '${directory.path}'
          '${Platform.pathSeparator}'
          '$_fileName',
    );
  }

  // ==========================================================
  // LOAD SAVED PHOTO
  // ==========================================================

  static Future<void> loadPhoto() async {
    try {
      final File file =
      await _photoFile();

      if (await file.exists()) {
        studentProfilePhotoNotifier
            .value = file;
      }
    } catch (_) {
      // Keep default profile icon if loading fails.
    }
  }

  // ==========================================================
  // SAVE PHOTO PERMANENTLY
  // ==========================================================

  static Future<File?> savePhoto(
      String sourcePath,
      ) async {
    try {
      final File sourceFile =
      File(sourcePath);

      if (!await sourceFile.exists()) {
        return null;
      }

      final File destinationFile =
      await _photoFile();

      final File savedFile =
      await sourceFile.copy(
        destinationFile.path,
      );

      studentProfilePhotoNotifier
          .value = savedFile;

      return savedFile;
    } catch (_) {
      return null;
    }
  }

  // ==========================================================
  // REMOVE SAVED PHOTO
  // ==========================================================

  static Future<void> removePhoto() async {
    try {
      final File file =
      await _photoFile();

      if (await file.exists()) {
        await file.delete();
      }

      studentProfilePhotoNotifier
          .value = null;
    } catch (_) {
      studentProfilePhotoNotifier
          .value = null;
    }
  }
}


// ============================================================
// STUDENT PROFILE HEADER
// ============================================================

class StudentProfileHeader
    extends StatefulWidget {
  const StudentProfileHeader({
    super.key,
  });

  @override
  State<StudentProfileHeader>
  createState() =>
      _StudentProfileHeaderState();
}

class _StudentProfileHeaderState
    extends State<StudentProfileHeader> {

  final ImagePicker _imagePicker =
  ImagePicker();

  @override
  void initState() {
    super.initState();

    // Load previously saved photo.
    StudentProfilePhotoStorage
        .loadPhoto();
  }

  // ==========================================================
  // CHANGE PROFILE PHOTO
  // ==========================================================

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

      final File? savedFile =
      await StudentProfilePhotoStorage
          .savePhoto(
        selectedImage.path,
      );

      if (!mounted) {
        return;
      }

      if (savedFile == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Unable to save profile photo.',
            ),
          ),
        );

        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Profile photo updated successfully.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Unable to select profile photo.',
          ),
        ),
      );
    }
  }

  // ==========================================================
  // PHOTO OPTIONS
  // ==========================================================

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

                // =================================================
                // GALLERY
                // =================================================

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

                // =================================================
                // REMOVE PHOTO
                // =================================================

                if (studentProfilePhotoNotifier
                    .value !=
                    null)

                  ListTile(
                    leading:
                    const CircleAvatar(
                      child: Icon(
                        Icons
                            .delete_outline,
                      ),
                    ),

                    title: const Text(
                      'Remove Profile Photo',
                    ),

                    subtitle: const Text(
                      'Return to the default photo',
                    ),

                    onTap: () async {
                      Navigator.pop(
                        sheetContext,
                      );

                      await StudentProfilePhotoStorage
                          .removePhoto();
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

  // ==========================================================
  // PROFILE PHOTO
  // ==========================================================

  Widget _profilePhoto() {
    return ValueListenableBuilder<File?>(
      valueListenable:
      studentProfilePhotoNotifier,

      builder: (
          context,
          photo,
          child,
          ) {
        return Stack(
          children: [

            Container(
              width: 110,
              height: 110,

              decoration:
              const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              padding:
              const EdgeInsets.all(4),

              child: ClipOval(
                child: photo != null
                    ? Image.file(
                  photo,

                  width: 102,
                  height: 102,

                  fit: BoxFit.cover,
                )
                    : const CircleAvatar(
                  radius: 55,

                  backgroundColor:
                  Colors.white,

                  child: Icon(
                    Icons.person,

                    size: 60,

                    color:
                    Color(
                      0xFF5B5FEF,
                    ),
                  ),
                ),
              ),
            ),

            // ==================================================
            // EDIT BUTTON
            // ==================================================

            Positioned(
              right: 0,
              bottom: 0,

              child: GestureDetector(
                onTap:
                _showPhotoOptions,

                child: Container(
                  padding:
                  const EdgeInsets.all(
                    6,
                  ),

                  decoration:
                  const BoxDecoration(
                    color: Colors.white,
                    shape:
                    BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.edit,

                    color:
                    Color(
                      0xFF5B5FEF,
                    ),

                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.all(25),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(25),

        gradient:
        const LinearGradient(
          colors: [
            Color(0xFF5B5FEF),
            Color(0xFF7C83FD),
          ],
        ),
      ),

      child: Column(
        children: [

          _profilePhoto(),

          const SizedBox(
            height: 20,
          ),

          // ==================================================
          // EXISTING DATA — NOT EDITABLE
          // ==================================================

          const Text(
            "Mohammed Moinuddin",

            style: TextStyle(
              fontSize: 24,
              fontWeight:
              FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          const Text(
            "KUB24CSE118",

            style: TextStyle(
              color: Colors.white70,
              fontSize: 17,
            ),
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}