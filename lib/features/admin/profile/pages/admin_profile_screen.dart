import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/admin_profile_data.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() =>
      _AdminProfileScreenState();
}

class _AdminProfileScreenState
    extends State<AdminProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _roleController;

  bool _isEditing = false;

  String? _profilePhoto;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: currentAdminProfile.name,
    );

    _emailController = TextEditingController(
      text: currentAdminProfile.email,
    );

    _mobileController = TextEditingController(
      text: currentAdminProfile.mobile,
    );

    _roleController = TextEditingController(
      text: currentAdminProfile.role,
    );

    _profilePhoto = currentAdminProfile.profilePhoto;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _roleController.dispose();

    super.dispose();
  }

  // ============================================================
  // PICK PROFILE PHOTO
  // ============================================================

  Future<void> _pickProfilePhoto() async {
    try {
      final XFile? pickedFile =
      await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile == null) {
        return;
      }

      setState(() {
        _profilePhoto = pickedFile.path;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to select profile photo.',
          ),
        ),
      );
    }
  }

  // ============================================================
  // REMOVE PROFILE PHOTO
  // ============================================================

  void _removeProfilePhoto() {
    setState(() {
      _profilePhoto = null;
    });
  }

  // ============================================================
  // SAVE PROFILE
  // ============================================================

  void _saveProfile() {
    final String name =
    _nameController.text.trim();

    final String email =
    _emailController.text.trim();

    final String mobile =
    _mobileController.text.trim();

    final String role =
    _roleController.text.trim();

    if (name.isEmpty) {
      _showMessage(
        'Admin name cannot be empty.',
      );
      return;
    }

    if (email.isEmpty) {
      _showMessage(
        'Email address cannot be empty.',
      );
      return;
    }

    if (mobile.isEmpty) {
      _showMessage(
        'Mobile number cannot be empty.',
      );
      return;
    }

    if (role.isEmpty) {
      _showMessage(
        'Role cannot be empty.',
      );
      return;
    }

    // ==========================================================
    // UPDATE CURRENT ADMIN PROFILE
    // ==========================================================

    updateCurrentAdminProfile(
      name: name,
      email: email,
      mobile: mobile,
      role: role,
      profilePhoto: _profilePhoto,
    );

    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Admin profile updated successfully.',
        ),
      ),
    );
  }

  // ============================================================
  // CANCEL EDITING
  // ============================================================

  void _cancelEditing() {
    setState(() {
      _nameController.text =
          currentAdminProfile.name;

      _emailController.text =
          currentAdminProfile.email;

      _mobileController.text =
          currentAdminProfile.mobile;

      _roleController.text =
          currentAdminProfile.role;

      _profilePhoto =
          currentAdminProfile.profilePhoto;

      _isEditing = false;
    });
  }

  // ============================================================
  // SHOW MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // PROFILE IMAGE
  // ============================================================

  ImageProvider? _profileImageProvider() {
    final String? photo =
        _profilePhoto;

    if (photo == null ||
        photo.trim().isEmpty) {
      return null;
    }

    final File file = File(photo);

    // ==========================================================
    // LOCAL IMAGE
    // ==========================================================

    if (file.existsSync()) {
      return FileImage(file);
    }

    // ==========================================================
    // ASSET IMAGE
    // ==========================================================

    return AssetImage(photo);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final ImageProvider? profileImage =
    _profileImageProvider();

    final String displayName =
    _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim()
        : 'KUTS Admin';

    final String displayRole =
    _roleController.text.trim().isNotEmpty
        ? _roleController.text.trim()
        : 'Transport Administrator';

    return Scaffold(
      backgroundColor:
      const Color(0xfff4f7fb),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Admin Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff1f2937),
          ),
        ),

        centerTitle: false,

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Color(0xff1f2937),
        ),

        actions: [
          if (!_isEditing)
            IconButton(
              tooltip: 'Edit Profile',

              icon: const Icon(
                Icons.edit_outlined,
              ),

              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),

          if (_isEditing)
            IconButton(
              tooltip: 'Cancel',

              icon: const Icon(
                Icons.close,
              ),

              onPressed:
              _cancelEditing,
            ),

          const SizedBox(
            width: 8,
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Container(
        width: double.infinity,

        decoration:
        const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          top: false,

          child: SingleChildScrollView(
            padding:
            const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              30,
            ),

            child: Column(
              children: [

                // ==================================================
                // PROFILE HEADER CARD
                // ==================================================

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(24),

                  decoration:
                  BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(
                      24,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                          alpha: 0.06,
                        ),

                        blurRadius: 18,

                        offset:
                        const Offset(
                          0,
                          8,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      // ==========================================
                      // PROFILE PHOTO
                      // ==========================================

                      Stack(
                        alignment:
                        Alignment.bottomRight,

                        children: [

                          CircleAvatar(
                            radius: 58,

                            backgroundColor:
                            const Color(
                              0xffede9fe,
                            ),

                            backgroundImage:
                            profileImage,

                            child:
                            profileImage ==
                                null
                                ? Text(
                              displayName
                                  .isNotEmpty
                                  ? displayName[
                              0]
                                  .toUpperCase()
                                  : 'A',

                              style:
                              const TextStyle(
                                fontSize:
                                42,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color:
                                Color(
                                  0xff6d3fc0,
                                ),
                              ),
                            )
                                : null,
                          ),

                          // ========================================
                          // CAMERA BUTTON
                          // ========================================

                          if (_isEditing)
                            Material(
                              color:
                              const Color(
                                0xff6366f1,
                              ),

                              shape:
                              const CircleBorder(),

                              child: InkWell(
                                customBorder:
                                const CircleBorder(),

                                onTap:
                                _pickProfilePhoto,

                                child:
                                const Padding(
                                  padding:
                                  EdgeInsets.all(
                                    10,
                                  ),

                                  child:
                                  Icon(
                                    Icons
                                        .camera_alt_outlined,
                                    color:
                                    Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // ==========================================
                      // PHOTO BUTTONS
                      // ==========================================

                      if (_isEditing) ...[
                        const SizedBox(
                          height: 8,
                        ),

                        TextButton.icon(
                          onPressed:
                          _pickProfilePhoto,

                          icon:
                          const Icon(
                            Icons
                                .photo_library_outlined,
                          ),

                          label:
                          const Text(
                            'Change Profile Photo',
                          ),
                        ),

                        if (_profilePhoto !=
                            null &&
                            _profilePhoto!
                                .trim()
                                .isNotEmpty)
                          TextButton(
                            onPressed:
                            _removeProfilePhoto,

                            child:
                            const Text(
                              'Remove Photo',
                              style:
                              TextStyle(
                                color:
                                Colors.red,
                              ),
                            ),
                          ),
                      ],

                      const SizedBox(
                        height: 8,
                      ),

                      // ==========================================
                      // ADMIN NAME
                      // ==========================================

                      Text(
                        displayName,

                        textAlign:
                        TextAlign.center,

                        style:
                        const TextStyle(
                          fontSize: 22,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Color(0xff111827),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // ==========================================
                      // ADMIN ROLE
                      // ==========================================

                      Text(
                        displayRole,

                        textAlign:
                        TextAlign.center,

                        style:
                        const TextStyle(
                          fontSize: 13,
                          color:
                          Color(0xff4f46e5),
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ==================================================
                // PROFILE INFORMATION
                // ==================================================

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(
                    20,
                  ),

                  decoration:
                  BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(
                      22,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                          alpha: 0.05,
                        ),

                        blurRadius: 14,

                        offset:
                        const Offset(
                          0,
                          6,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      const Text(
                        'Profile Information',
                        style:
                        TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Color(0xff111827),
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // ==========================================
                      // NAME
                      // ==========================================

                      _buildProfileField(
                        label:
                        'Full Name',

                        icon:
                        Icons
                            .person_outline,

                        controller:
                        _nameController,

                        enabled:
                        _isEditing,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // ==========================================
                      // EMAIL
                      // ==========================================

                      _buildProfileField(
                        label:
                        'Email Address',

                        icon:
                        Icons
                            .email_outlined,

                        controller:
                        _emailController,

                        enabled:
                        _isEditing,

                        keyboardType:
                        TextInputType
                            .emailAddress,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // ==========================================
                      // MOBILE
                      // ==========================================

                      _buildProfileField(
                        label:
                        'Mobile Number',

                        icon:
                        Icons
                            .phone_outlined,

                        controller:
                        _mobileController,

                        enabled:
                        _isEditing,

                        keyboardType:
                        TextInputType
                            .phone,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // ==========================================
                      // ROLE
                      // ==========================================

                      _buildProfileField(
                        label:
                        'Role',

                        icon:
                        Icons
                            .admin_panel_settings_outlined,

                        controller:
                        _roleController,

                        enabled:
                        _isEditing,
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // SAVE BUTTON
                // ==================================================

                if (_isEditing) ...[
                  const SizedBox(
                    height: 22,
                  ),

                  SizedBox(
                    width: double.infinity,

                    height: 54,

                    child:
                    FilledButton.icon(
                      onPressed:
                      _saveProfile,

                      icon:
                      const Icon(
                        Icons
                            .save_outlined,
                      ),

                      label:
                      const Text(
                        'Save Changes',

                        style:
                        TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      style:
                      FilledButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xff6366f1,
                        ),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width: double.infinity,

                    height: 50,

                    child:
                    OutlinedButton(
                      onPressed:
                      _cancelEditing,

                      style:
                      OutlinedButton
                          .styleFrom(
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            16,
                          ),
                        ),
                      ),

                      child:
                      const Text(
                        'Cancel',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE FIELD
  // ============================================================

  Widget _buildProfileField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,

      enabled: enabled,

      keyboardType:
      keyboardType,

      onChanged: (_) {
        setState(() {});
      },

      // ==========================================================
      // IMPORTANT:
      // Keep text dark even when the field is in VIEW mode.
      // ==========================================================

      style: const TextStyle(
        color: Color(0xff1f2937),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      cursorColor:
      const Color(0xff6366f1),

      decoration:
      InputDecoration(
        labelText: label,

        // ========================================================
        // LABEL COLOR
        // ========================================================

        labelStyle:
        const TextStyle(
          color: Color(0xff6b7280),
          fontSize: 13,
        ),

        floatingLabelStyle:
        const TextStyle(
          color: Color(0xff6366f1),
          fontSize: 12,
          fontWeight:
          FontWeight.w500,
        ),

        // ========================================================
        // ICON COLOR
        // ========================================================

        prefixIcon: Icon(
          icon,
          color: const Color(0xff6b7280),
        ),

        // ========================================================
        // FIELD BACKGROUND
        // ========================================================

        filled: true,

        fillColor: enabled
            ? const Color(
          0xfff8fafc,
        )
            : const Color(
          0xfff1f5f9,
        ),

        // ========================================================
        // DEFAULT BORDER
        // ========================================================

        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),

          borderSide:
          const BorderSide(
            color:
            Color(0xffdbe3ec),
          ),
        ),

        // ========================================================
        // ENABLED BORDER
        // ========================================================

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),

          borderSide:
          const BorderSide(
            color:
            Color(0xffdbe3ec),
          ),
        ),

        // ========================================================
        // FOCUSED BORDER
        // ========================================================

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),

          borderSide:
          const BorderSide(
            color:
            Color(0xff6366f1),
            width: 1.5,
          ),
        ),

        // ========================================================
        // DISABLED BORDER
        // ========================================================

        disabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),

          borderSide:
          const BorderSide(
            color:
            Color(0xffdbe3ec),
          ),
        ),

        // ========================================================
        // CONTENT PADDING
        // ========================================================

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}