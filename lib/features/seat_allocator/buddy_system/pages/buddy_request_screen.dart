import 'package:flutter/material.dart';

class BuddyRequestScreen extends StatefulWidget {
  const BuddyRequestScreen({super.key});

  @override
  State<BuddyRequestScreen> createState() =>
      _BuddyRequestScreenState();
}

class _BuddyRequestScreenState
    extends State<BuddyRequestScreen> {
  // ==========================================================
  // DEMO REQUEST DATA
  // ==========================================================

  String leaderName = "Mansoor";
  String leaderUsn = "KUB24CSE120";

  String groupId = "203";

  final List<Map<String, String>> groupMembers = [
    {
      "name": "Mansoor",
      "usn": "KUB24CSE120",
      "status": "Leader",
    },
    {
      "name": "Mohammed Moinuddin",
      "usn": "KUB24CSE118",
      "status": "Pending",
    },
    {
      "name": "Owais",
      "usn": "KUB24CSE125",
      "status": "Confirmed",
    },
  ];

  bool requestResponded = false;
  bool accepted = false;

  // ==========================================================
  // ACCEPT REQUEST
  // ==========================================================

  void _acceptRequest() {
    setState(() {
      accepted = true;
      requestResponded = true;

      for (final member in groupMembers) {
        if (member["name"] == "Mohammed Moinuddin") {
          member["status"] = "Confirmed";
        }
      }
    });

    _showMessage(
      "Buddy request accepted successfully.",
      const Color(0xFF16A34A),
    );
  }

  // ==========================================================
  // DECLINE REQUEST
  // ==========================================================

  void _declineRequest() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Decline Buddy Request?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          content: const Text(
            "You will not become a member of this Buddy Group. "
                "You can join another group later.",
            style: TextStyle(
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  accepted = false;
                  requestResponded = true;
                });

                _showMessage(
                  "Buddy request declined.",
                  Colors.red,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Decline"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

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

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          "Buddy Request",
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
          top: false,

          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: const EdgeInsets.fromLTRB(
              16,
              10,
              16,
              30,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                _buildRequestHeader(),

                const SizedBox(height: 16),

                _buildInvitationCard(),

                const SizedBox(height: 16),

                _buildGroupDetails(),

                const SizedBox(height: 16),

                _buildAttendanceInformation(),

                const SizedBox(height: 20),

                if (!requestResponded)
                  _buildActionButtons()
                else
                  _buildResponseCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // REQUEST HEADER
  // ==========================================================

  Widget _buildRequestHeader() {
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
            color: const Color(0xFF5B5FEF)
                .withOpacity(.25),
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
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),

            child: const Center(
              child: Icon(
                Icons.group_add_rounded,
                color: Colors.white,
                size: 30,
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
                  "Buddy Invitation",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "You have received a request to join a Buddy Group.",
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
  // INVITATION CARD
  // ==========================================================

  Widget _buildInvitationCard() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Text(
            "You have been invited by",
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              CircleAvatar(
                radius: 25,

                backgroundColor:
                const Color(0xFFEDE9FE),

                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF7C3AED),
                  size: 27,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      leaderName,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      leaderUsn,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              _statusBadge(
                "Leader",
                const Color(0xFF7C3AED),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius:
              BorderRadius.circular(13),
              border: Border.all(
                color: const Color(0xFFE9D5FF),
              ),
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.groups_rounded,
                  color: Color(0xFF7C3AED),
                  size: 20,
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    "Buddy Group #$groupId",
                    style: const TextStyle(
                      color: Color(0xFF5B21B6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _statusBadge(
                  "Pending",
                  const Color(0xFFD97706),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GROUP DETAILS
  // ==========================================================

  Widget _buildGroupDetails() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.groups_rounded,
                color: Color(0xFF5B5FEF),
                size: 22,
              ),

              SizedBox(width: 9),

              Text(
                "Group Members",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          ...groupMembers.map(
                (member) => _memberCard(member),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MEMBER CARD
  // ==========================================================

  Widget _memberCard(
      Map<String, String> member,
      ) {
    final String status =
        member["status"] ?? "Pending";

    final bool isLeader =
        status == "Leader";

    Color statusColor;

    switch (status) {
      case "Confirmed":
        statusColor = const Color(0xFF16A34A);
        break;

      case "Leader":
        statusColor = const Color(0xFF7C3AED);
        break;

      default:
        statusColor = const Color(0xFFD97706);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 9),

      padding: const EdgeInsets.all(11),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),

        borderRadius:
        BorderRadius.circular(13),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 21,

            backgroundColor:
            isLeader
                ? const Color(0xFFEDE9FE)
                : const Color(0xFFE0F2FE),

            child: Icon(
              isLeader
                  ? Icons.star_rounded
                  : Icons.person_rounded,

              color:
              isLeader
                  ? const Color(0xFF7C3AED)
                  : const Color(0xFF0284C7),

              size: 21,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  member["name"] ?? "",
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  member["usn"] ?? "",
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),

          _statusBadge(
            status,
            statusColor,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ATTENDANCE INFORMATION
  // ==========================================================

  Widget _buildAttendanceInformation() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),

        borderRadius:
        BorderRadius.circular(17),

        border: Border.all(
          color: const Color(0xFFFDE68A),
        ),
      ),

      child: const Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                Icons.event_available_rounded,
                color: Color(0xFFD97706),
                size: 21,
              ),

              SizedBox(width: 8),

              Text(
                "Important",
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 9),

          Text(
            "Accepting this request does not automatically "
                "give you a seat. You must confirm your daily "
                "attendance before seat allocation.",
            style: TextStyle(
              color: Color(0xFF78350F),
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTION BUTTONS
  // ==========================================================

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,

          child: ElevatedButton.icon(
            onPressed: _acceptRequest,

            icon: const Icon(
              Icons.check_circle_outline_rounded,
            ),

            label: const Text(
              "Accept Buddy Request",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xFF16A34A),

              foregroundColor: Colors.white,

              elevation: 2,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          height: 50,

          child: OutlinedButton.icon(
            onPressed: _declineRequest,

            icon: const Icon(
              Icons.close_rounded,
            ),

            label: const Text(
              "Decline Request",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,

              side: const BorderSide(
                color: Colors.red,
              ),

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // RESPONSE CARD
  // ==========================================================

  Widget _buildResponseCard() {
    final Color color =
    accepted
        ? const Color(0xFF16A34A)
        : Colors.red;

    final IconData icon =
    accepted
        ? Icons.check_circle_rounded
        : Icons.cancel_rounded;

    final String title =
    accepted
        ? "Buddy Request Accepted"
        : "Buddy Request Declined";

    final String description =
    accepted
        ? "You are now a confirmed member of Buddy Group #$groupId."
        : "You are not a member of Buddy Group #$groupId.";

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: color.withOpacity(.08),

        borderRadius:
        BorderRadius.circular(17),

        border: Border.all(
          color: color.withOpacity(.25),
        ),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 11,
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
  // WHITE CARD
  // ==========================================================

  Widget _whiteCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

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
            color: Colors.black.withOpacity(.06),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }

  // ==========================================================
  // STATUS BADGE
  // ==========================================================

  Widget _statusBadge(
      String text,
      Color color,
      ) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(.10),

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}