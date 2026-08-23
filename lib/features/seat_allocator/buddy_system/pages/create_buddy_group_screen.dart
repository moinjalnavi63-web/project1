import 'package:flutter/material.dart';

class CreateBuddyGroupScreen extends StatefulWidget {
  const CreateBuddyGroupScreen({super.key});

  @override
  State<CreateBuddyGroupScreen> createState() =>
      _CreateBuddyGroupScreenState();
}

class _CreateBuddyGroupScreenState
    extends State<CreateBuddyGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController friend1NameController =
  TextEditingController();

  final TextEditingController friend1UsnController =
  TextEditingController();

  final TextEditingController friend2NameController =
  TextEditingController();

  final TextEditingController friend2UsnController =
  TextEditingController();

  bool isCreating = false;

  @override
  void dispose() {
    friend1NameController.dispose();
    friend1UsnController.dispose();
    friend2NameController.dispose();
    friend2UsnController.dispose();
    super.dispose();
  }

  // ==========================================================
  // CREATE GROUP
  // ==========================================================

  Future<void> _createGroup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String friend1Name =
    friend1NameController.text.trim();

    final String friend1Usn =
    friend1UsnController.text.trim().toUpperCase();

    final String friend2Name =
    friend2NameController.text.trim();

    final String friend2Usn =
    friend2UsnController.text.trim().toUpperCase();

    // ----------------------------------------------------------
    // Duplicate Friend 1 / Friend 2 check
    // ----------------------------------------------------------

    if (friend2Name.isNotEmpty &&
        friend1Usn.toLowerCase() ==
            friend2Usn.toLowerCase()) {
      _showError(
        "Friend 1 and Friend 2 cannot be the same student.",
      );
      return;
    }

    setState(() {
      isCreating = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      isCreating = false;
    });

    // ----------------------------------------------------------
    // RETURN CREATED GROUP
    // ----------------------------------------------------------

    Navigator.pop(
      context,
      {
        "success": true,

        "friend1Name": friend1Name,
        "friend1Usn": friend1Usn,

        "friend2Name": friend2Name,
        "friend2Usn": friend2Usn,
      },
    );
  }

  // ==========================================================
  // ERROR
  // ==========================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          "Create Buddy Group",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF111827),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              18,
              10,
              18,
              30,
            ),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  _buildHeader(),

                  const SizedBox(height: 20),

                  _buildRuleCard(),

                  const SizedBox(height: 18),

                  _buildFriendForm(),

                  const SizedBox(height: 20),

                  _buildGroupPreview(),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    height: 54,

                    child: ElevatedButton.icon(
                      onPressed:
                      isCreating
                          ? null
                          : _createGroup,

                      icon: isCreating
                          ? const SizedBox(
                        width: 19,
                        height: 19,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(
                        Icons.group_add_rounded,
                      ),

                      label: Text(
                        isCreating
                            ? "Creating Group..."
                            : "Create Buddy Group",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF5B5FEF),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                        const Color(0xFF9CA3AF),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      "Friends will receive a Buddy Request after creation.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7C3AED),
            Color(0xFF5B5FEF),
            Color(0xFF4F46E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(23),

        boxShadow: [
          BoxShadow(
            color:
            const Color(0xFF5B5FEF)
                .withOpacity(.22),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color:
              Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),

            child: const Center(
              child: Text(
                "🤝",
                style: TextStyle(
                  fontSize: 31,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  "Build Your Buddy Group",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Choose 1 or 2 friends to sit together whenever possible.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // RULE CARD
  // ==========================================================

  Widget _buildRuleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFFDE68A),
        ),
      ),

      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFD97706),
            size: 22,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              "A Buddy Group must contain at least 2 students and can have a maximum of 3 students including you.",
              style: TextStyle(
                color: Color(0xFF78350F),
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FRIEND FORM
  // ==========================================================

  Widget _buildFriendForm() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Text(
            "Add Friends",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Enter both the friend's name and USN.",
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Friend 1",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          _friendField(
            controller: friend1NameController,
            label: "Friend 1 Name",
            hint: "Example: Mansoor",
            icon: Icons.person_outline_rounded,
            requiredField: true,
          ),

          const SizedBox(height: 10),

          _friendField(
            controller: friend1UsnController,
            label: "Friend 1 USN",
            hint: "Example: KUB24CSE120",
            icon: Icons.badge_outlined,
            requiredField: true,
            isUsn: true,
          ),

          const SizedBox(height: 20),

          const Text(
            "Friend 2 (Optional)",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          _friendField(
            controller: friend2NameController,
            label: "Friend 2 Name",
            hint: "Example: Owais",
            icon: Icons.person_outline_rounded,
            requiredField: false,
          ),

          const SizedBox(height: 10),

          _friendField(
            controller: friend2UsnController,
            label: "Friend 2 USN",
            hint: "Example: KUB24CSE125",
            icon: Icons.badge_outlined,
            requiredField: false,
            isUsn: true,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FIELD
  // ==========================================================

  Widget _friendField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool requiredField,
    bool isUsn = false,
  }) {
    return TextFormField(
      controller: controller,

      textCapitalization:
      isUsn
          ? TextCapitalization.characters
          : TextCapitalization.words,

      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 13,
      ),

      validator: (value) {
        final text =
            value?.trim() ?? "";

        if (requiredField &&
            text.isEmpty) {
          return "Please enter $label.";
        }

        if (isUsn && text.isNotEmpty) {
          final usnRegex = RegExp(
            r'^KUB\d{2}[A-Z]+\d{3}$',
            caseSensitive: false,
          );

          if (!usnRegex.hasMatch(text)) {
            return "Enter a valid USN.";
          }
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle: const TextStyle(
          color: Color(0xFF374151),
        ),

        hintStyle: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 11,
        ),

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF5B5FEF),
        ),

        filled: true,
        fillColor: const Color(0xFFF9FAFB),

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF5B5FEF),
            width: 1.5,
          ),
        ),

        errorBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PREVIEW
  // ==========================================================

  Widget _buildGroupPreview() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.preview_outlined,
                color: Color(0xFF5B5FEF),
                size: 21,
              ),

              SizedBox(width: 8),

              Text(
                "Group Preview",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          _previewMember(
            name: "You",
            usn: "KUB24CSE118",
            icon: Icons.person_rounded,
            color: const Color(0xFF7C3AED),
          ),

          const SizedBox(height: 8),

          _previewMember(
            name:
            friend1NameController.text.isEmpty
                ? "Friend 1"
                : friend1NameController.text,
            usn:
            friend1UsnController.text.isEmpty
                ? "USN"
                : friend1UsnController.text
                .toUpperCase(),
            icon:
            Icons.person_add_alt_1_rounded,
            color: const Color(0xFF0284C7),
          ),

          const SizedBox(height: 8),

          _previewMember(
            name:
            friend2NameController.text.isEmpty
                ? "Friend 2 (Optional)"
                : friend2NameController.text,
            usn:
            friend2UsnController.text.isEmpty
                ? "USN"
                : friend2UsnController.text
                .toUpperCase(),
            icon:
            Icons.person_add_alt_1_rounded,
            color: const Color(0xFF0891B2),
          ),

          const SizedBox(height: 12),

          const Text(
            "Friend requests will remain pending until they accept.",
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewMember({
    required String name,
    required String usn,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,

            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: color,
              size: 19,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  usn,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF9CA3AF),
            size: 19,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // WHITE CARD
  // ==========================================================

  Widget _whiteCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.96),
        borderRadius:
        BorderRadius.circular(19),

        border: Border.all(
          color: Colors.white,
          width: 1.2,
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.06),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }
}