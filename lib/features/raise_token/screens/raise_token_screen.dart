import 'package:flutter/material.dart';

import '../models/token_model.dart';
import '../services/token_service.dart';

class RaiseTokenScreen extends StatefulWidget {
  const RaiseTokenScreen({super.key});

  @override
  State<RaiseTokenScreen> createState() => _RaiseTokenScreenState();
}

class _RaiseTokenScreenState extends State<RaiseTokenScreen> {
  // ============================================================
  // FORM
  // ============================================================

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _mobileController =
  TextEditingController();

  final TextEditingController _descriptionController =
  TextEditingController();

  // ============================================================
  // TOKEN SERVICE
  // ============================================================

  final TokenService _tokenService = TokenService();

  // ============================================================
  // SELECTIONS
  // ============================================================

  String? selectedBus;
  String? selectedStop;
  String? selectedIssue;

  String selectedPriority = "Low";

  // ============================================================
  // TOKENS
  // ============================================================

  List<TokenModel> get _myTokens =>
      _tokenService.getAllTokens();

  // ============================================================
  // BUS NUMBERS
  // ============================================================

  final List<String> busNumbers = [
    "Bus 01",
    "Bus 02",
    "Bus 03",
    "Bus 04",
    "Bus 05",
    "Bus 06",
    "Bus 07",
    "Bus 08",
    "Bus 09",
    "Bus 10",
    "Bus 11",
    "Bus 12",
    "Bus 13",
    "Bus 14",
    "Bus 15",
    "Bus 16",
    "Bus 17",
    "Bus 18",
    "Bus 19",
    "Bus 20",
    "Bus 21",
    "Bus 22",
    "Bus 23",
    "Bus 24",
  ];

  // ============================================================
  // BUS STOPS
  // ============================================================

  final List<String> busStops = [
    "Main Gate",
    "Railway Station",
    "Hospet",
    "Koppal",
    "Gadag",
    "College Road",
    "Market",
    "Bus Stand",
  ];

  // ============================================================
  // ISSUE CATEGORIES
  // ============================================================

  final List<IssueCategory> issueCategories = [
    IssueCategory(
      title: "Late Bus",
      subtitle: "Bus delayed",
      icon: Icons.access_time_rounded,
      iconColor: Colors.orange,
      backgroundColor: Color(0xFFFFF3E0),
    ),
    IssueCategory(
      title: "Breakdown",
      subtitle: "Vehicle problem",
      icon: Icons.build_rounded,
      iconColor: Colors.redAccent,
      backgroundColor: Color(0xFFFFEBEE),
    ),
    IssueCategory(
      title: "Driver Issue",
      subtitle: "Driver related",
      icon: Icons.person_pin_rounded,
      iconColor: Colors.deepPurple,
      backgroundColor: Color(0xFFEDE7F6),
    ),
    IssueCategory(
      title: "Bus Missing",
      subtitle: "Bus unavailable",
      icon: Icons.directions_bus_filled_rounded,
      iconColor: Colors.blue,
      backgroundColor: Color(0xFFE3F2FD),
    ),
    IssueCategory(
      title: "Overcrowded",
      subtitle: "Too many people",
      icon: Icons.groups_rounded,
      iconColor: Colors.pink,
      backgroundColor: Color(0xFFFCE4EC),
    ),
    IssueCategory(
      title: "Safety Issue",
      subtitle: "Safety concern",
      icon: Icons.warning_rounded,
      iconColor: Colors.red,
      backgroundColor: Color(0xFFFFEBEE),
    ),
    IssueCategory(
      title: "Route Issue",
      subtitle: "Wrong route",
      icon: Icons.map_rounded,
      iconColor: Colors.teal,
      backgroundColor: Color(0xFFE0F2F1),
    ),
    IssueCategory(
      title: "Lost Item",
      subtitle: "Item missing",
      icon: Icons.backpack_rounded,
      iconColor: Colors.indigo,
      backgroundColor: Color(0xFFE8EAF6),
    ),
    IssueCategory(
      title: "Other Issue",
      subtitle: "Something else",
      icon: Icons.more_horiz_rounded,
      iconColor: Colors.grey,
      backgroundColor: Color(0xFFF1F3F4),
    ),
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // ============================================================
  // SUBMIT TOKEN
  // ============================================================

  void submitToken() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedIssue == null) {
      _showMessage(
        "Please select an issue category.",
        Colors.red,
      );
      return;
    }

    if (selectedBus == null) {
      _showMessage(
        "Please select your bus number.",
        Colors.red,
      );
      return;
    }

    if (selectedStop == null) {
      _showMessage(
        "Please select your pickup stop.",
        Colors.red,
      );
      return;
    }

    // Convert UI priority text to TokenPriority enum.
    final TokenPriority priority;

    switch (selectedPriority) {
      case "Medium":
        priority = TokenPriority.medium;
        break;

      case "High":
        priority = TokenPriority.high;
        break;

      default:
        priority = TokenPriority.low;
    }

    // ==========================================================
    // CREATE TOKEN USING TOKEN SERVICE
    // ==========================================================

    final TokenModel token = _tokenService.createToken(
      // TEMPORARY student ID.
      //
      // Later this will come from the logged-in student profile.
      studentId: "KUB24CSE118",

      studentName: _nameController.text.trim(),

      busNumber: selectedBus!,

      pickupStop: selectedStop!,

      issueCategory: selectedIssue!,

      priority: priority,

      description: _descriptionController.text.trim(),
    );

    setState(() {});

    _showSuccessDialog(token.tokenId);
  }

  // ============================================================
  // SUCCESS DIALOG
  // ============================================================

  void _showSuccessDialog(String tokenId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Column(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.green,
                  size: 38,
                ),
              ),
              SizedBox(height: 14),
              Text(
                "Token Raised Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Your issue has been submitted to the transport admin.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF5B5FEF),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "YOUR TOKEN ID",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      tokenId,
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _clearForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B5FEF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CLEAR FORM
  // ============================================================

  void _clearForm() {
    _nameController.clear();
    _mobileController.clear();
    _descriptionController.clear();

    setState(() {
      selectedBus = null;
      selectedStop = null;
      selectedIssue = null;
      selectedPriority = "Low";
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
      String message,
      Color color,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Container(
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            14,
            12,
            14,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),

                const SizedBox(height: 16),

                _buildStudentInformationCard(),

                const SizedBox(height: 16),

                _buildIssueCategorySection(),

                const SizedBox(height: 16),

                _buildPrioritySection(),

                const SizedBox(height: 16),

                _buildDescriptionCard(),

                const SizedBox(height: 18),

                _buildSubmitButton(),

                const SizedBox(height: 26),

                _buildMyTokensSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5B5FEF),
            Color(0xFF7C83FD),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B5FEF).withOpacity(.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.confirmation_number_rounded,
              color: Color(0xFF5B5FEF),
              size: 30,
            ),
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Raise a Token",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Report an issue — your token reaches the admin instantly.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STUDENT INFORMATION
  // ============================================================

  Widget _buildStudentInformationCard() {
    return _sectionCard(
      title: "Student Information",
      icon: Icons.person_outline_rounded,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: "Your Name",
            hint: "Enter your full name",
            icon: Icons.person_outline_rounded,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Enter your name";
              }

              return null;
            },
          ),

          const SizedBox(height: 12),

          _buildDropdown(
            value: selectedBus,
            label: "Bus Number",
            hint: "Select your bus",
            icon: Icons.directions_bus_outlined,
            items: busNumbers,
            onChanged: (value) {
              setState(() {
                selectedBus = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Select your bus";
              }

              return null;
            },
          ),

          const SizedBox(height: 12),

          _buildTextField(
            controller: _mobileController,
            label: "Roll Number/Id",
            hint: "Enter mobile or roll number",
            icon: Icons.phone_android_outlined,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Enter mobile or roll number";
              }

              return null;
            },
          ),

          const SizedBox(height: 12),

          _buildDropdown(
            value: selectedStop,
            label: "Your Stop",
            hint: "Select pickup stop",
            icon: Icons.location_on_outlined,
            items: busStops,
            onChanged: (value) {
              setState(() {
                selectedStop = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Select your stop";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ISSUE CATEGORY
  // ============================================================

  Widget _buildIssueCategorySection() {
    return _sectionCard(
      title: "What is the problem?",
      icon: Icons.report_problem_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select one issue category",
            style: TextStyle(
              color: Color(0xFF374151),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: issueCategories.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: .92,
            ),
            itemBuilder: (context, index) {
              final issue = issueCategories[index];

              final bool selected =
                  selectedIssue == issue.title;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIssue = issue.title;
                  });
                },
                child: AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 220),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFFFF0F7)
                        : Colors.white,
                    borderRadius:
                    BorderRadius.circular(15),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFFEC4899)
                          : const Color(0xFFE5E7EB),
                      width: selected ? 2.2 : 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: selected
                            ? const Color(0xFFEC4899)
                            .withOpacity(.20)
                            : Colors.black
                            .withOpacity(.05),
                        blurRadius: selected ? 9 : 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration:
                        const Duration(milliseconds: 220),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFFFE0EF)
                              : issue.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          issue.icon,
                          color: selected
                              ? const Color(0xFFEC4899)
                              : issue.iconColor,
                          size: 23,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        issue.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFFBE185D)
                              : const Color(0xFF111827),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        issue.subtitle,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 8.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (selected)
                        const Padding(
                          padding:
                          EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFFEC4899),
                            size: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRIORITY
  // ============================================================

  Widget _buildPrioritySection() {
    return _sectionCard(
      title: "Priority Level",
      icon: Icons.flag_outlined,
      child: Row(
        children: [
          _priorityButton(
            title: "Low",
            icon: Icons.circle,
            color: Colors.green,
          ),

          const SizedBox(width: 8),

          _priorityButton(
            title: "Medium",
            icon: Icons.circle,
            color: Colors.orange,
          ),

          const SizedBox(width: 8),

          _priorityButton(
            title: "High",
            icon: Icons.circle,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _priorityButton({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final bool selected =
        selectedPriority == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPriority = title;
          });
        },
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: selected
                ? color.withOpacity(.12)
                : Colors.white,
            borderRadius:
            BorderRadius.circular(13),
            border: Border.all(
              color: selected
                  ? color
                  : const Color(0xFFE5E7EB),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 12,
                color: color,
              ),

              const SizedBox(width: 5),

              Flexible(
                child: Text(
                  title,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? color
                        : const Color(0xFF111827),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescriptionCard() {
    return _sectionCard(
      title: "Describe the Issue",
      icon: Icons.description_outlined,
      child: TextFormField(
        controller: _descriptionController,
        minLines: 4,
        maxLines: 6,
        style: const TextStyle(
          color: Color(0xFF111827),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText:
          "Tell us what happened in detail...",
          hintStyle: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 13,
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          contentPadding:
          const EdgeInsets.all(14),
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF5B5FEF),
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return "Please describe the issue";
          }

          if (value.trim().length < 5) {
            return "Please provide more details";
          }

          return null;
        },
      ),
    );
  }

  // ============================================================
  // SUBMIT BUTTON
  // ============================================================

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEC4899),
              Color(0xFFD946EF),
            ],
          ),
          borderRadius:
          BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEC4899)
                  .withOpacity(.30),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: submitToken,
          icon: const Icon(
            Icons.confirmation_number_rounded,
          ),
          label: const Text(
            "Submit Token",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
            Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor:
            Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MY TOKENS
  // ============================================================

  Widget _buildMyTokensSection() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.confirmation_number_outlined,
              color: Color(0xFF5B5FEF),
            ),

            const SizedBox(width: 8),

            const Expanded(
              child: Text(
                "My Tokens",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (_myTokens.isNotEmpty)
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  "${_myTokens.length}",
                  style: const TextStyle(
                    color: Color(0xFF5B5FEF),
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 5),

        const Text(
          "Track the issues you have reported.",
          style: TextStyle(
            color: Color(0xFF374151),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        if (_myTokens.isEmpty)
          _emptyTokens()
        else
          Column(
            children: _myTokens
                .map(
                  (token) => _tokenCard(token),
            )
                .toList(),
          ),
      ],
    );
  }

  // ============================================================
  // EMPTY TOKENS
  // ============================================================

  Widget _emptyTokens() {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        vertical: 28,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.90),
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
            Color(0xFFEDE9FE),
            child: Icon(
              Icons.confirmation_number_outlined,
              color: Color(0xFF5B5FEF),
              size: 30,
            ),
          ),

          SizedBox(height: 12),

          Text(
            "No Tokens Yet",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            "You haven't reported any transport issues.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF374151),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOKEN CARD
  // ============================================================

  Widget _tokenCard(TokenModel token) {
    return GestureDetector(
      onTap: () {
        _showTokenDetails(token);
      },
      child: Container(
        width: double.infinity,
        margin:
        const EdgeInsets.only(bottom: 12),
        padding:
        const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFFFCE7F3),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.confirmation_number_rounded,
                    color: Color(0xFFEC4899),
                    size: 21,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Token ID",
                        style: TextStyle(
                          color:
                          Color(0xFF4B5563),
                          fontSize: 10,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        token.tokenId,
                        style: const TextStyle(
                          color:
                          Color(0xFF111827),
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                _statusBadge(
                  token.statusText,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _tokenInfo(
                    Icons.report_problem_outlined,
                    "Issue",
                    token.issueCategory,
                  ),
                ),

                Expanded(
                  child: _tokenInfo(
                    Icons.directions_bus_outlined,
                    "Bus",
                    token.busNumber,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _tokenInfo(
                    Icons.flag_outlined,
                    "Priority",
                    token.priorityText,
                  ),
                ),

                Expanded(
                  child: _tokenInfo(
                    Icons.access_time_rounded,
                    "Raised",
                    _formatDate(
                      token.createdAt,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOKEN INFORMATION
  // ============================================================

  Widget _tokenInfo(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF5B5FEF),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color:
                  Color(0xFF4B5563),
                  fontSize: 9,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: const TextStyle(
                  color:
                  Color(0xFF111827),
                  fontSize: 11,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case "Resolved":
        background =
        const Color(0xFFDCFCE7);
        foreground =
        const Color(0xFF15803D);
        break;

      case "Reviewing":
        background =
        const Color(0xFFFEF3C7);
        foreground =
        const Color(0xFFB45309);
        break;

      default:
        background =
        const Color(0xFFFEE2E2);
        foreground =
        const Color(0xFFDC2626);
    }

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // TOKEN DETAILS
  // ============================================================

  void _showTokenDetails(
      TokenModel token,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          constraints:
          const BoxConstraints(
            maxHeight: 700,
          ),
          decoration:
          const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.vertical(
              top: Radius.circular(26),
            ),
          ),
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.fromLTRB(
              20,
              14,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration:
                    BoxDecoration(
                      color:
                      const Color(0xFFD1D5DB),
                      borderRadius:
                      BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Token header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor:
                      Color(0xFFFCE7F3),
                      child: Icon(
                        Icons.confirmation_number_rounded,
                        color:
                        Color(0xFFEC4899),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        token.tokenId,
                        style:
                        const TextStyle(
                          color:
                          Color(0xFF111827),
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Status
                Row(
                  children: [
                    const Text(
                      "Current Status",
                      style: TextStyle(
                        color:
                        Color(0xFF374151),
                        fontSize: 13,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    _statusBadge(
                      token.statusText,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _detailRow(
                  "Issue Category",
                  token.issueCategory,
                ),

                _detailRow(
                  "Bus Number",
                  token.busNumber,
                ),

                _detailRow(
                  "Pickup Stop",
                  token.pickupStop,
                ),

                _detailRow(
                  "Student Name",
                  token.studentName,
                ),

                _detailRow(
                  "Student ID",
                  token.studentId,
                ),

                _detailRow(
                  "Priority",
                  token.priorityText,
                ),

                _detailRow(
                  "Date & Time",
                  _formatDate(
                    token.createdAt,
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                const Text(
                  "Problem Description",
                  style: TextStyle(
                    color:
                    Color(0xFF111827),
                    fontSize: 15,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(14),
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(0xFFF9FAFB),
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                    border: Border.all(
                      color:
                      const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Text(
                    token.description,
                    style:
                    const TextStyle(
                      color:
                      Color(0xFF374151),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Admin response
                const Text(
                  "Admin Response",
                  style: TextStyle(
                    color:
                    Color(0xFF111827),
                    fontSize: 15,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(14),
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(0xFFF3F4FF),
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                    border: Border.all(
                      color:
                      const Color(0xFFE0E7FF),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.admin_panel_settings_outlined,
                        color:
                        Color(0xFF5B5FEF),
                        size: 21,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          token.adminResponse
                              .trim()
                              .isEmpty
                              ? "No response from admin yet."
                              : token.adminResponse,
                          style:
                          const TextStyle(
                            color:
                            Color(0xFF374151),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Status timeline
                _buildStatusTimeline(token),

                const SizedBox(height: 18),

                // Refresh
                SizedBox(
                  width: double.infinity,
                  child:
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(
                        sheetContext,
                      );

                      setState(() {});

                      _showMessage(
                        "Token status refreshed.",
                        const Color(
                          0xFF5B5FEF,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                    ),
                    label: const Text(
                      "Refresh Status",
                    ),
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor:
                      const Color(
                        0xFF5B5FEF,
                      ),
                      side:
                      const BorderSide(
                        color:
                        Color(0xFF5B5FEF),
                      ),
                      padding:
                      const EdgeInsets
                          .symmetric(
                        vertical: 13,
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // STATUS TIMELINE
  // ============================================================

  Widget _buildStatusTimeline(
      TokenModel token,
      ) {
    final bool raised = true;

    final bool reviewing =
        token.status == TokenStatus.reviewing ||
            token.status == TokenStatus.resolved;

    final bool resolved =
        token.status == TokenStatus.resolved;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          "Status Timeline",
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        _timelineItem(
          title: "Token Raised",
          subtitle:
          _formatDate(token.createdAt),
          active: raised,
          completed: raised,
          isLast: false,
        ),

        _timelineItem(
          title: "Admin Reviewing",
          subtitle: reviewing
              ? _formatDate(token.updatedAt)
              : "Waiting for admin",
          active: reviewing,
          completed: reviewing,
          isLast: false,
        ),

        _timelineItem(
          title: "Issue Being Resolved",
          subtitle: resolved
              ? "Completed"
              : "Pending",
          active: resolved,
          completed: resolved,
          isLast: false,
        ),

        _timelineItem(
          title: "Resolved",
          subtitle: token.resolvedAt != null
              ? _formatDate(
            token.resolvedAt!,
          )
              : "Pending",
          active: resolved,
          completed: resolved,
          isLast: true,
        ),
      ],
    );
  }

  Widget _timelineItem({
    required String title,
    required String subtitle,
    required bool active,
    required bool completed,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 200,
                  ),
                  width: 24,
                  height: 24,
                  decoration:
                  BoxDecoration(
                    shape: BoxShape.circle,
                    color: completed
                        ? const Color(
                      0xFF5B5FEF,
                    )
                        : const Color(
                      0xFFE5E7EB,
                    ),
                    boxShadow: active
                        ? [
                      BoxShadow(
                        color:
                        const Color(
                          0xFF5B5FEF,
                        ).withOpacity(.25),
                        blurRadius: 8,
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    completed
                        ? Icons.check
                        : Icons.circle,
                    size:
                    completed ? 14 : 8,
                    color: completed
                        ? Colors.white
                        : const Color(
                      0xFF9CA3AF,
                    ),
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: completed
                          ? const Color(
                        0xFFC7D2FE,
                      )
                          : const Color(
                        0xFFE5E7EB,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(
                bottom: 18,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: active
                          ? const Color(
                        0xFF111827,
                      )
                          : const Color(
                        0xFF6B7280,
                      ),
                      fontSize: 13,
                      fontWeight:
                      active
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style:
                    const TextStyle(
                      color:
                      Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DETAIL ROW
  // ============================================================

  Widget _detailRow(
      String label,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 13,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                color:
                Color(0xFF4B5563),
                fontSize: 12,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style:
              const TextStyle(
                color:
                Color(0xFF111827),
                fontSize: 13,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMON SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:
        Colors.white.withOpacity(.94),
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
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFEDE9FE),
                  borderRadius:
                  BorderRadius.circular(
                    10,
                  ),
                ),
                child: Icon(
                  icon,
                  color:
                  const Color(0xFF5B5FEF),
                  size: 20,
                ),
              ),

              const SizedBox(width: 9),

              Text(
                title,
                style: const TextStyle(
                  color:
                  Color(0xFF111827),
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          child,
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?)
    validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle:
        const TextStyle(
          color: Color(0xFF374151),
          fontWeight: FontWeight.w600,
        ),

        hintStyle:
        const TextStyle(
          color: Color(0xFF4B5563),
          fontSize: 12,
        ),

        prefixIcon: Icon(
          icon,
          color:
          const Color(0xFF5B5FEF),
          size: 21,
        ),

        filled: true,
        fillColor:
        const Color(0xFFF9FAFB),

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),

        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFFE5E7EB),
          ),
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFFE5E7EB),
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFF5B5FEF),
            width: 2,
          ),
        ),

        errorBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      validator: validator,
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _buildDropdown({
    required String? value,
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?>
    onChanged,
    required String? Function(String?)
    validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,

      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle:
        const TextStyle(
          color: Color(0xFF374151),
          fontWeight: FontWeight.w600,
        ),

        prefixIcon: Icon(
          icon,
          color:
          const Color(0xFF5B5FEF),
          size: 21,
        ),

        filled: true,
        fillColor:
        const Color(0xFFF9FAFB),

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),

        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFFE5E7EB),
          ),
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFFE5E7EB),
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(13),
          borderSide:
          const BorderSide(
            color:
            Color(0xFF5B5FEF),
            width: 2,
          ),
        ),
      ),

      items: items.map(
            (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style:
              const TextStyle(
                color:
                Color(0xFF111827),
                fontWeight:
                FontWeight.w600,
              ),
            ),
          );
        },
      ).toList(),

      onChanged: onChanged,

      validator: validator,
    );
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(
      DateTime date,
      ) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    int hour = date.hour;

    final String period =
    hour >= 12 ? "PM" : "AM";

    hour = hour % 12;

    if (hour == 0) {
      hour = 12;
    }

    final String minute =
    date.minute.toString().padLeft(
      2,
      '0',
    );

    return "${date.day} "
        "${months[date.month - 1]} "
        "${date.year}, "
        "$hour:$minute $period";
  }
}

// ================================================================
// ISSUE CATEGORY MODEL
// ================================================================

class IssueCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const IssueCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}