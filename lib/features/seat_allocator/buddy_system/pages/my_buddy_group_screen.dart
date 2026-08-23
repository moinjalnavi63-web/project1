import 'package:flutter/material.dart';

class MyBuddyGroupScreen extends StatefulWidget {
  const MyBuddyGroupScreen({super.key});

  @override
  State<MyBuddyGroupScreen> createState() =>
      _MyBuddyGroupScreenState();
}

class _MyBuddyGroupScreenState extends State<MyBuddyGroupScreen> {
  // ==========================================================
  // DEMO DATA
  // ==========================================================

  String groupId = "203";

  String leaderName = "Mohammed Moinuddin";

  final List<Map<String, String>> members = [
    {
      "name": "Mohammed Moinuddin",
      "usn": "KUB24CSE118",
      "status": "Leader",
    },
    {
      "name": "Mansoor",
      "usn": "KUB24CSE120",
      "status": "Confirmed",
    },
    {
      "name": "Owais",
      "usn": "KUB24CSE125",
      "status": "Confirmed",
    },
  ];

  final List<Map<String, dynamic>> weeklyHistory = [
    {
      "day": "Monday",
      "together": true,
      "seats": "21, 22, 23",
    },
    {
      "day": "Tuesday",
      "together": true,
      "seats": "31, 32, 33",
    },
    {
      "day": "Wednesday",
      "together": false,
      "seats": "18, 29, 30",
    },
    {
      "day": "Thursday",
      "together": true,
      "seats": "41, 42, 43",
    },
    {
      "day": "Friday",
      "together": false,
      "seats": "12, 24, 25",
    },
  ];

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    const int togetherDays = 3;
    const int targetDays = 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          "My Buddy Group",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =================================================
                // GROUP HEADER
                // =================================================

                _buildGroupHeader(),

                const SizedBox(height: 16),

                // =================================================
                // GROUP MEMBERS
                // =================================================

                _buildMembersCard(),

                const SizedBox(height: 16),

                // =================================================
                // WEEKLY PROGRESS
                // =================================================

                _buildWeeklyProgress(
                  togetherDays,
                  targetDays,
                ),

                const SizedBox(height: 16),

                // =================================================
                // CURRENT SEAT ALLOCATION
                // =================================================

                _buildCurrentAllocation(),

                const SizedBox(height: 16),

                // =================================================
                // NEXT ALLOCATION
                // =================================================

                _buildNextAllocation(),

                const SizedBox(height: 16),

                // =================================================
                // WEEKLY HISTORY
                // =================================================

                _buildWeeklyHistory(),

                const SizedBox(height: 16),

                // =================================================
                // GROUP INFORMATION
                // =================================================

                _buildInformationCard(),

                const SizedBox(height: 18),

                // =================================================
                // MANAGE BUTTON
                // =================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton.icon(
                    onPressed: _openManageGroup,

                    icon: const Icon(
                      Icons.settings_outlined,
                    ),

                    label: const Text(
                      "Manage Buddy Group",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF5B5FEF),

                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
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

  // ==========================================================
  // GROUP HEADER
  // ==========================================================

  Widget _buildGroupHeader() {
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

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 55,
                height: 55,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.18),
                  shape: BoxShape.circle,
                ),

                child: const Center(
                  child: Text(
                    "🤝",
                    style: TextStyle(
                      fontSize: 29,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "My Buddy Group",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Smart friend seat pairing",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),

              _headerStatusBadge(),
            ],
          ),

          const SizedBox(height: 17),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.12),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Row(
              children: [

                const Icon(
                  Icons.group_rounded,
                  color: Colors.white,
                  size: 20,
                ),

                const SizedBox(width: 9),

                const Text(
                  "Group #",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),

                Text(
                  groupId,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                const Text(
                  "Leader: ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),

                Flexible(
                  child: Text(
                    leaderName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.18),
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Text(
        "ACTIVE",
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // MEMBERS
  // ==========================================================

  Widget _buildMembersCard() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              const Icon(
                Icons.groups_rounded,
                color: Color(0xFF5B5FEF),
                size: 23,
              ),

              const SizedBox(width: 9),

              const Expanded(
                child: Text(
                  "Group Members",
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Text(
                  "${members.length}/3",
                  style: const TextStyle(
                    color: Color(0xFF6D28D9),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          ...members.map(
                (member) => _memberTile(member),
          ),
        ],
      ),
    );
  }

  Widget _memberTile(
      Map<String, String> member,
      ) {
    final bool isLeader =
        member["status"] == "Leader";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      padding: const EdgeInsets.all(11),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 22,

            backgroundColor: isLeader
                ? const Color(0xFFEDE9FE)
                : const Color(0xFFE0F2FE),

            child: Icon(
              isLeader
                  ? Icons.star_rounded
                  : Icons.person_rounded,

              color: isLeader
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 13,
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

          _memberStatus(
            member["status"] ?? "",
            isLeader,
          ),
        ],
      ),
    );
  }

  Widget _memberStatus(
      String status,
      bool isLeader,
      ) {
    final Color color = isLeader
        ? const Color(0xFF7C3AED)
        : const Color(0xFF16A34A);

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
        status,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // WEEKLY PROGRESS
  // ==========================================================

  Widget _buildWeeklyProgress(
      int togetherDays,
      int targetDays,
      ) {
    final double progress =
        togetherDays / targetDays;

    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.emoji_events_outlined,
                  color: Color(0xFF16A34A),
                  size: 22,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Weekly Progress",
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      "Minimum target: 3 days together",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "$togetherDays/$targetDays",
                style: const TextStyle(
                  color: Color(0xFF16A34A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,

              backgroundColor:
              const Color(0xFFE5E7EB),

              valueColor:
              const AlwaysStoppedAnimation(
                Color(0xFF22C55E),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              const Icon(
                Icons.check_circle,
                color: Color(0xFF16A34A),
                size: 17,
              ),

              const SizedBox(width: 6),

              const Expanded(
                child: Text(
                  "Weekly requirement achieved",
                  style: TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                "$togetherDays days",
                style: const TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CURRENT ALLOCATION
  // ==========================================================

  Widget _buildCurrentAllocation() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              const Icon(
                Icons.event_seat_rounded,
                color: Color(0xFF5B5FEF),
                size: 23,
              ),

              const SizedBox(width: 9),

              const Expanded(
                child: Text(
                  "Current Allocation",
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              _smallBadge(
                "Together",
                const Color(0xFF16A34A),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF5F3FF),
                  Color(0xFFEFF6FF),
                ],
              ),

              borderRadius:
              BorderRadius.circular(15),

              border: Border.all(
                color: const Color(0xFFE0E7FF),
              ),
            ),

            child: Row(
              children: [

                _seatItem(
                  "Mansoor",
                  "21",
                ),

                const SizedBox(width: 7),

                _seatItem(
                  "Moin",
                  "22",
                ),

                const SizedBox(width: 7),

                _seatItem(
                  "Owais",
                  "23",
                ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          const Row(
            children: [

              Icon(
                Icons.location_on_outlined,
                color: Color(0xFF5B5FEF),
                size: 15,
              ),

              SizedBox(width: 5),

              Text(
                "Middle section • Today",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seatItem(
      String name,
      String seat,
      ) {
    return Expanded(
      child: Container(
        padding:
        const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 3,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(11),

          border: Border.all(
            color: const Color(0xFFDDE2FF),
          ),
        ),

        child: Column(
          children: [

            Text(
              "Seat $seat",
              style: const TextStyle(
                color: Color(0xFF5B5FEF),
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // NEXT ALLOCATION
  // ==========================================================

  Widget _buildNextAllocation() {
    return _whiteCard(
      child: Row(
        children: [

          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius:
              BorderRadius.circular(13),
            ),

            child: const Icon(
              Icons.update_rounded,
              color: Color(0xFF0284C7),
            ),
          ),

          const SizedBox(width: 11),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "Next Allocation",
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  "Tomorrow • Front section",
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFF9CA3AF),
            size: 16,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // WEEKLY HISTORY
  // ==========================================================

  Widget _buildWeeklyHistory() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Row(
            children: [

              Icon(
                Icons.history_rounded,
                color: Color(0xFF5B5FEF),
                size: 22,
              ),

              SizedBox(width: 9),

              Text(
                "Weekly History",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          ...weeklyHistory.map(
                (day) => _historyRow(day),
          ),
        ],
      ),
    );
  }

  Widget _historyRow(
      Map<String, dynamic> day,
      ) {
    final bool together =
    day["together"] as bool;

    return Container(
      margin:
      const EdgeInsets.only(bottom: 8),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius:
        BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          Expanded(
            child: Text(
              day["day"] as String,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            "Seats ${day["seats"]}",
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 9.5,
            ),
          ),

          const SizedBox(width: 9),

          Icon(
            together
                ? Icons.check_circle
                : Icons.cancel,

            color: together
                ? const Color(0xFF16A34A)
                : const Color(0xFF9CA3AF),

            size: 18,
          ),

          const SizedBox(width: 5),

          Text(
            together
                ? "Together"
                : "Separate",

            style: TextStyle(
              color: together
                  ? const Color(0xFF15803D)
                  : const Color(0xFF6B7280),

              fontSize: 9.5,

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // INFORMATION
  // ==========================================================

  Widget _buildInformationCard() {
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
                Icons.lightbulb_outline_rounded,
                color: Color(0xFFD97706),
                size: 21,
              ),

              SizedBox(width: 8),

              Text(
                "How Buddy Allocation Works",
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Text(
            "• Your group can contain 2–3 students.\n"
                "• Every member must confirm attendance.\n"
                "• The system tries to keep attending members together.\n"
                "• Buddy groups are prioritized before individual students.\n"
                "• The weekly target is at least 3 days together.\n"
                "• Seat positions rotate to maintain fairness.",
            style: TextStyle(
              color: Color(0xFF78350F),
              fontSize: 11,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MANAGE GROUP
  // ==========================================================

  void _openManageGroup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _ManageGroupPlaceholder(),
      ),
    );
  }

  // ==========================================================
  // COMMON CARD
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
  // SMALL BADGE
  // ==========================================================

  Widget _smallBadge(
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
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ==========================================================
// TEMPORARY PLACEHOLDER
// ==========================================================
//
// We will replace this with:
// manage_buddy_group_screen.dart
//
// after that file is provided.
// ==========================================================

class _ManageGroupPlaceholder extends StatelessWidget {
  const _ManageGroupPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Buddy Group"),
      ),

      body: const Center(
        child: Text(
          "Manage Buddy Group screen\nwill be connected next.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}