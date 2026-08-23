import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../data/demo_announcements.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState
    extends State<CreateAnnouncementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  String selectedType = 'Transportation Details';
  String selectedAudience = 'All students';

  // Specific target values
  String? selectedBus;
  String? selectedRoute;
  String? selectedYear;
  String? selectedBranch;

  PlatformFile? selectedFile;

  bool isSubmitting = false;

  final List<String> announcementTypes = const [
    'Transportation Details',
    'Transport Alert',
    'General',
    'Notice / Circular',
    'Emergency',
    'Bus Specific',
    'Route / Stop',
  ];

  final List<String> audiences = const [
    'All students',
    'Specific bus',
    'Specific route',
    'Specific year',
    'Specific branch',
    'Drivers',
    'Faculty',
    'Everyone',
  ];

  // ============================================================
  // BUS LIST
  // ============================================================

  final List<String> buses = List.generate(
    24,
        (index) => 'Bus ${index + 1}',
  );

  // ============================================================
  // ROUTE LIST
  // ============================================================

  final List<String> routes = const [
    'Hospet',
    'Gangavathi',
    'Koppal',
    'Ballari',
    'Siruguppa',
    'Kushtagi',
    'Kanakagiri',
    'Karatagi',
    'Hampi',
    'Kampli',
  ];

  // ============================================================
  // YEAR LIST
  // ============================================================

  final List<String> years = const [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  // ============================================================
  // BRANCH LIST
  // ============================================================

  final List<String> branches = const [
    'CSE',
    'ISE',
    'ECE',
    'EEE',
    'AIML',
    'AIDS',
    'MECH',
    'CIVIL',
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // ============================================================
  // AUDIENCE CHANGE
  // ============================================================

  void _onAudienceChanged(String? value) {
    if (value == null) return;

    setState(() {
      selectedAudience = value;

      // Clear previous specific selections.
      selectedBus = null;
      selectedRoute = null;
      selectedYear = null;
      selectedBranch = null;
    });
  }

  // ============================================================
  // PICK FILE
  // ============================================================

  Future<void> _pickFile() async {
    try {
      final FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        withData: true,
        allowedExtensions: const [
          'pdf',
          'png',
          'jpg',
          'jpeg',
          'doc',
          'docx',
          'txt',
        ],
      );

      if (!mounted) return;

      if (result == null || result.files.isEmpty) {
        return;
      }

      final PlatformFile file = result.files.first;

      const int maxFileSize = 10 * 1024 * 1024;

      if (file.size > maxFileSize) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'File size must not exceed 10 MB.',
            ),
          ),
        );

        return;
      }

      setState(() {
        selectedFile = file;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Unable to select file: $e',
          ),
        ),
      );
    }
  }

  // ============================================================
  // REMOVE FILE
  // ============================================================

  void _removeFile() {
    setState(() {
      selectedFile = null;
    });
  }

  // ============================================================
  // VALIDATE SPECIFIC TARGET
  // ============================================================

  bool _validateSpecificTarget() {
    if (selectedAudience == 'Specific bus' &&
        selectedBus == null) {
      _showError('Please select a bus.');
      return false;
    }

    if (selectedAudience == 'Specific route' &&
        selectedRoute == null) {
      _showError('Please select a route.');
      return false;
    }

    if (selectedAudience == 'Specific year' &&
        selectedYear == null) {
      _showError('Please select a year.');
      return false;
    }

    if (selectedAudience == 'Specific branch' &&
        selectedBranch == null) {
      _showError('Please select a branch.');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // CREATE ANNOUNCEMENT
  // ============================================================

  Future<void> _createAnnouncement() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_validateSpecificTarget()) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    if (!mounted) return;

    final DateTime now = DateTime.now();

    // ------------------------------------------------------------
    // KEEP EXISTING SPECIFIC TARGET LOGIC
    // ------------------------------------------------------------

    String finalAudience = selectedAudience;

    if (selectedAudience == 'Specific bus' &&
        selectedBus != null) {
      finalAudience = 'Specific bus: $selectedBus';
    }

    if (selectedAudience == 'Specific route' &&
        selectedRoute != null) {
      finalAudience = 'Specific route: $selectedRoute';
    }

    if (selectedAudience == 'Specific year' &&
        selectedYear != null) {
      finalAudience = 'Specific year: $selectedYear';
    }

    if (selectedAudience == 'Specific branch' &&
        selectedBranch != null) {
      finalAudience = 'Specific branch: $selectedBranch';
    }

    // ------------------------------------------------------------
    // ATTACHMENT INFORMATION
    // ------------------------------------------------------------

    String? attachmentType;

    if (selectedFile != null) {
      final extension =
      selectedFile!.extension?.toLowerCase();

      if (extension == 'pdf') {
        attachmentType = 'pdf';
      } else if (extension == 'png' ||
          extension == 'jpg' ||
          extension == 'jpeg') {
        attachmentType = 'image';
      } else {
        attachmentType = 'document';
      }
    }

    // ------------------------------------------------------------
    // CREATE ANNOUNCEMENT
    // ------------------------------------------------------------

    final AnnouncementData announcement =
    AnnouncementData(
      title: titleController.text.trim(),

      description:
      descriptionController.text.trim(),

      type: selectedType,

      targetAudience: finalAudience,

      dateTime: now,

      // ----------------------------------------------------------
      // ATTACHMENT DATA
      // ----------------------------------------------------------

      attachmentName:
      selectedFile?.name,

      attachmentPath:
      selectedFile?.path,

      attachmentType:
      attachmentType,
    );

    // ============================================================
    // IMPORTANT UPDATE
    // ============================================================
    //
    // Add the newly created announcement directly to the SAME
    // shared demoAnnouncements list.
    //
    // This makes the announcement immediately available to:
    //
    // 1. Admin Announcements
    // 2. Admin Dashboard
    // 3. Announcement Details
    //
    // We do NOT return the announcement here because the existing
    // AdminAnnouncementsScreen already inserts returned results.
    // Returning it would create a duplicate announcement.
    // ============================================================

    demoAnnouncements.insert(0, announcement);

    setState(() {
      isSubmitting = false;
    });

    // ============================================================
    // CLOSE CREATE ANNOUNCEMENT SCREEN
    // ============================================================

    Navigator.pop(context);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f7fb),

      appBar: AppBar(
        title: const Text(
          'Create Announcement',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xff1f2937),
      ),

      body: Container(
        decoration: const BoxDecoration(
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
          child: Form(
            key: _formKey,

            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                30,
              ),

              children: [
                // ==================================================
                // TITLE
                // ==================================================

                const Text(
                  'Announcement Title',
                  style: TextStyle(
                    color: Color(0xff1f2937),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                TextFormField(
                  controller: titleController,

                  style: const TextStyle(
                    color: Color(0xff111827),
                  ),

                  decoration: InputDecoration(
                    hintText:
                    'Enter announcement title',

                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),

                    prefixIcon: const Icon(
                      Icons.title_outlined,
                      color: Color(0xff374151),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide:
                      const BorderSide(
                        color: Color(0xff6366f1),
                        width: 1.5,
                      ),
                    ),

                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter announcement title';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // ==================================================
                // TYPE
                // ==================================================

                const Text(
                  'Announcement Type',
                  style: TextStyle(
                    color: Color(0xff1f2937),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                _dropdown(
                  value: selectedType,
                  items: announcementTypes,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      selectedType = value;
                    });
                  },
                ),

                const SizedBox(height: 18),

                // ==================================================
                // DESCRIPTION
                // ==================================================

                const Text(
                  'Announcement Details',
                  style: TextStyle(
                    color: Color(0xff1f2937),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                TextFormField(
                  controller: descriptionController,

                  minLines: 5,
                  maxLines: 8,

                  style: const TextStyle(
                    color: Color(0xff111827),
                  ),

                  decoration: InputDecoration(
                    hintText:
                    'Enter complete transportation details...',

                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 8,
                        top: 14,
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: Color(0xff374151),
                      ),
                    ),

                    prefixIconConstraints:
                    const BoxConstraints(
                      minWidth: 45,
                    ),

                    contentPadding:
                    const EdgeInsets.all(16),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                      borderSide:
                      const BorderSide(
                        color: Color(0xff6366f1),
                        width: 1.5,
                      ),
                    ),

                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter announcement details';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // ==================================================
                // AUDIENCE
                // ==================================================

                const Text(
                  'Audience',
                  style: TextStyle(
                    color: Color(0xff1f2937),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                _dropdown(
                  value: selectedAudience,
                  items: audiences,
                  onChanged: _onAudienceChanged,
                ),

                // ==================================================
                // SPECIFIC TARGET
                // ==================================================

                if (selectedAudience == 'Specific bus')
                  _specificTargetDropdown(
                    title: 'Select Bus',
                    icon: Icons.directions_bus_outlined,
                    value: selectedBus,
                    items: buses,
                    onChanged: (value) {
                      setState(() {
                        selectedBus = value;
                      });
                    },
                  ),

                if (selectedAudience == 'Specific route')
                  _specificTargetDropdown(
                    title: 'Select Route',
                    icon: Icons.route_outlined,
                    value: selectedRoute,
                    items: routes,
                    onChanged: (value) {
                      setState(() {
                        selectedRoute = value;
                      });
                    },
                  ),

                if (selectedAudience == 'Specific year')
                  _specificTargetDropdown(
                    title: 'Select Year',
                    icon: Icons.school_outlined,
                    value: selectedYear,
                    items: years,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                  ),

                if (selectedAudience == 'Specific branch')
                  _specificTargetDropdown(
                    title: 'Select Branch',
                    icon: Icons.account_tree_outlined,
                    value: selectedBranch,
                    items: branches,
                    onChanged: (value) {
                      setState(() {
                        selectedBranch = value;
                      });
                    },
                  ),

                const SizedBox(height: 18),

                // ==================================================
                // ATTACHMENT
                // ==================================================

                const Text(
                  'Attachment',
                  style: TextStyle(
                    color: Color(0xff1f2937),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                _attachmentWidget(),

                const SizedBox(height: 25),

                // ==================================================
                // PUBLISH
                // ==================================================

                SizedBox(
                  height: 54,

                  child: FilledButton.icon(
                    onPressed:
                    isSubmitting
                        ? null
                        : _createAnnouncement,

                    icon: isSubmitting
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(
                      Icons.campaign_outlined,
                    ),

                    label: Text(
                      isSubmitting
                          ? 'Publishing...'
                          : 'Publish Announcement',

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: FilledButton.styleFrom(
                      backgroundColor:
                      const Color(0xff6366f1),

                      foregroundColor:
                      Colors.white,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NORMAL DROPDOWN
  // ============================================================

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,

      isExpanded: true,

      style: const TextStyle(
        color: Color(0xff111827),
        fontSize: 14,
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(16),
          borderSide:
          const BorderSide(
            color: Color(0xff6366f1),
            width: 1.5,
          ),
        ),
      ),

      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,

          child: Text(
            item,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: Color(0xff111827),
              fontSize: 14,
            ),
          ),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }

  // ============================================================
  // SPECIFIC TARGET DROPDOWN
  // ============================================================

  Widget _specificTargetDropdown({
    required String title,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff1f2937),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          DropdownButtonFormField<String>(
            initialValue: value,

            isExpanded: true,

            style: const TextStyle(
              color: Color(0xff111827),
              fontSize: 14,
            ),

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              prefixIcon: Icon(
                icon,
                color: const Color(0xff6366f1),
              ),

              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),

              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),

              enabledBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),

              focusedBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(16),
                borderSide:
                const BorderSide(
                  color: Color(0xff6366f1),
                  width: 1.5,
                ),
              ),
            ),

            hint: Text(
              'Choose $title',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,

                child: Text(
                  item,
                  overflow:
                  TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Color(0xff111827),
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ATTACHMENT
  // ============================================================

  Widget _attachmentWidget() {
    if (selectedFile != null) {
      return Container(
        width: double.infinity,

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color:
                const Color(0xffede9fe),

                borderRadius:
                BorderRadius.circular(12),
              ),

              child: Icon(
                _getFileIcon(
                  selectedFile!.extension,
                ),

                color:
                const Color(0xff7c3aed),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    selectedFile!.name,

                    maxLines: 2,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Color(0xff111827),
                      fontWeight:
                      FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _fileSize(
                      selectedFile!.size,
                    ),

                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: _removeFile,

              icon: const Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,

            decoration: const BoxDecoration(
              color: Color(0xffede9fe),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: Color(0xff7c3aed),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Attach File or PDF',

            style: TextStyle(
              color: Color(0xff111827),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'PDF, Images, DOC, DOCX or TXT',

            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            'Maximum size: 10 MB',

            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 14),

          OutlinedButton.icon(
            onPressed: _pickFile,

            icon: const Icon(
              Icons.attach_file,
              size: 18,
            ),

            label: const Text(
              'Choose File',
            ),

            style: OutlinedButton.styleFrom(
              foregroundColor:
              const Color(0xff4338ca),

              side: const BorderSide(
                color: Color(0xff6366f1),
              ),

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILE ICON
  // ============================================================

  IconData _getFileIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;

      case 'png':
      case 'jpg':
      case 'jpeg':
        return Icons.image_outlined;

      case 'doc':
      case 'docx':
        return Icons.description_outlined;

      case 'txt':
        return Icons.text_snippet_outlined;

      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  // ============================================================
  // FILE SIZE
  // ============================================================

  String _fileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}