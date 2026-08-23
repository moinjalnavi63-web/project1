import 'package:flutter/material.dart';

class ManageBuddyGroupScreen extends StatefulWidget {
  const ManageBuddyGroupScreen({
    super.key,
  });

  @override
  State<ManageBuddyGroupScreen> createState() =>
      _ManageBuddyGroupScreenState();
}

class _ManageBuddyGroupScreenState
    extends State<ManageBuddyGroupScreen> {
  // ==========================================================
  // DEMO DATA
  // ==========================================================

  String leaderName = "Mohammed Moinuddin";

  List<Map<String, String>> members = [
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

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          "Manage Buddy Group",
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
                // =================================================
                // GROUP HEADER
                // =================================================

                _buildGroupHeader(),

                const SizedBox(height: 16),

                // =================================================
                // MEMBERS
                // =================================================

                _buildMembersCard(),

                const SizedBox(height: 16),

                // =================================================
                // LEADER ACTIONS
                // =================================================

                _buildActionsCard(),

                const SizedBox(height: 16),

                // =================================================
                // GROUP RULES
                // =================================================

                _buildRulesCard(),

                const SizedBox(height: 20),

                // =================================================
                // CLOSE GROUP
                // =================================================

                _buildCloseGroupButton(),
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

        borderRadius: BorderRadius.circular(22),

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
                  "Buddy Group #203",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Manage your group members and permissions.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 7),

                Text(
                  "Maximum 3 students",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
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
  // MEMBERS CARD
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

          const Divider(
            height: 1,
          ),

          const SizedBox(height: 12),

          ...members.map(
                (member) => _memberTile(member),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MEMBER TILE
  // ==========================================================

  Widget _memberTile(
      Map<String, String> member,
      ) {
    final bool isLeader =
        member["status"] == "Leader";

    return Container(
      margin:
      const EdgeInsets.only(bottom: 9),

      padding:
      const EdgeInsets.all(11),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),

        borderRadius:
        BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 23,

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

              size: 22,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  member["name"] ?? "",
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

          _statusBadge(
            member["status"] ?? "",
            isLeader
                ? const Color(0xFF7C3AED)
                : const Color(0xFF16A34A),
          ),

          if (!isLeader)
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Color(0xFF6B7280),
              ),

              onSelected: (value) {
                if (value == "remove") {
                  _confirmRemoveMember(member);
                }
              },

              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "remove",
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_remove_outlined,
                        color: Colors.red,
                        size: 19,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Remove Friend",
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTIONS CARD
  // ==========================================================

  Widget _buildActionsCard() {
    final bool canAddFriend =
        members.length < 3;

    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Text(
            "Group Actions",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 13),

          _actionTile(
            icon: Icons.person_add_alt_1_rounded,
            title: "Add Friend",
            subtitle: canAddFriend
                ? "Add another student to your group"
                : "Group is already full",
            color: const Color(0xFF5B5FEF),
            enabled: canAddFriend,
            onTap: canAddFriend
                ? _showAddFriendDialog
                : null,
          ),

          const SizedBox(height: 9),

          _actionTile(
            icon: Icons.swap_horiz_rounded,
            title: "Transfer Leadership",
            subtitle:
            "Give group leadership to another member",
            color: const Color(0xFF7C3AED),
            onTap:
            _showTransferLeadershipDialog,
          ),

          const SizedBox(height: 9),

          _actionTile(
            icon: Icons.person_remove_outlined,
            title: "Remove Friend",
            subtitle:
            "Remove a confirmed member",
            color: const Color(0xFFF97316),
            enabled: members.length > 1,
            onTap: members.length > 1
                ? _showRemoveFriendDialog
                : null,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTION TILE
  // ==========================================================

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: enabled ? onTap : null,

        borderRadius:
        BorderRadius.circular(14),

        child: Ink(
          padding:
          const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: enabled
                ? Colors.white
                : const Color(0xFFF3F4F6),

            borderRadius:
            BorderRadius.circular(14),

            border: Border.all(
              color: enabled
                  ? const Color(0xFFE5E7EB)
                  : const Color(0xFFE5E7EB),
            ),
          ),

          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,

                decoration: BoxDecoration(
                  color:
                  color.withOpacity(.10),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  icon,
                  color: enabled
                      ? color
                      : const Color(0xFF9CA3AF),
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: enabled
                            ? const Color(
                          0xFF111827,
                        )
                            : const Color(
                          0xFF9CA3AF,
                        ),
                        fontSize: 13,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color: enabled
                            ? const Color(
                          0xFF6B7280,
                        )
                            : const Color(
                          0xFF9CA3AF,
                        ),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: enabled
                    ? const Color(0xFF6B7280)
                    : const Color(0xFFD1D5DB),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // RULES
  // ==========================================================

  Widget _buildRulesCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

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
                Icons.info_outline_rounded,
                color: Color(0xFFD97706),
                size: 21,
              ),

              SizedBox(width: 8),

              Text(
                "Management Rules",
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
            "• Maximum 3 students can be in a group.\n"
                "• Removed students become available immediately.\n"
                "• A transferred leader receives management permissions.\n"
                "• A leader cannot simply leave without transferring leadership.\n"
                "• Only active confirmed members can become leaders.",
            style: TextStyle(
              color: Color(0xFF78350F),
              fontSize: 11.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CLOSE GROUP
  // ==========================================================

  Widget _buildCloseGroupButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,

      child: OutlinedButton.icon(
        onPressed: _showCloseGroupDialog,

        icon: const Icon(
          Icons.cancel_outlined,
          size: 19,
        ),

        label: const Text(
          "Close Buddy Group",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,

          side: const BorderSide(
            color: Colors.red,
          ),

          backgroundColor:
          Colors.white.withOpacity(.85),

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ADD FRIEND
  // ==========================================================

  void _showAddFriendDialog() {
    final controller =
    TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),

          title: const Text(
            "Add Friend",
            style: TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
            MainAxisSize.min,

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              const Text(
                "Enter your friend's USN.",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 13),

              TextField(
                controller: controller,

                textCapitalization:
                TextCapitalization.characters,

                decoration:
                InputDecoration(
                  labelText: "Friend USN",
                  prefixIcon: const Icon(
                    Icons.person_add_alt_1,
                    color:
                    Color(0xFF5B5FEF),
                  ),

                  filled: true,

                  fillColor:
                  const Color(0xFFF9FAFB),

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                      13,
                    ),
                  ),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final usn =
                controller.text
                    .trim()
                    .toUpperCase();

                if (usn.isEmpty) {
                  _showMessage(
                    "Enter a valid USN.",
                    isError: true,
                  );
                  return;
                }

                Navigator.pop(
                  dialogContext,
                );

                _showMessage(
                  "Buddy request sent to $usn.",
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF5B5FEF),
                foregroundColor:
                Colors.white,
              ),

              child:
              const Text("Send Request"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // REMOVE FRIEND
  // ==========================================================

  void _showRemoveFriendDialog() {
    final removableMembers =
    members.where(
          (member) =>
      member["status"] != "Leader",
    ).toList();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),

          title: const Text(
            "Remove Friend",
            style: TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
            MainAxisSize.min,

            children:
            removableMembers.map(
                  (member) {
                return ListTile(
                  contentPadding:
                  EdgeInsets.zero,

                  leading:
                  const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),

                  title: Text(
                    member["name"]!,
                  ),

                  subtitle: Text(
                    member["usn"]!,
                  ),

                  trailing:
                  const Icon(
                    Icons.chevron_right,
                  ),

                  onTap: () {
                    Navigator.pop(
                      dialogContext,
                    );

                    _confirmRemoveMember(
                      member,
                    );
                  },
                );
              },
            ).toList(),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CONFIRM REMOVE
  // ==========================================================

  void _confirmRemoveMember(
      Map<String, String> member,
      ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Remove Member?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            "Remove ${member["name"]} from Buddy Group #203?\n\n"
                "They will become available to join another group.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                setState(() {
                  members.remove(member);
                });

                _showMessage(
                  "${member["name"]} was removed from the group.",
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor:
                Colors.white,
              ),

              child:
              const Text("Remove"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // TRANSFER LEADERSHIP
  // ==========================================================

  void _showTransferLeadershipDialog() {
    final candidates =
    members.where(
          (member) =>
      member["status"] != "Leader" &&
          member["status"] == "Confirmed",
    ).toList();

    if (candidates.isEmpty) {
      _showMessage(
        "No confirmed member is available for leadership transfer.",
        isError: true,
      );

      return;
    }

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),

          title: const Text(
            "Transfer Leadership",
            style: TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
            MainAxisSize.min,

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              const Text(
                "Select a confirmed member to become the new leader.",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 12),

              ...candidates.map(
                    (member) {
                  return ListTile(
                    contentPadding:
                    EdgeInsets.zero,

                    leading:
                    const CircleAvatar(
                      backgroundColor:
                      Color(0xFFEDE9FE),

                      child: Icon(
                        Icons.person,
                        color:
                        Color(0xFF7C3AED),
                      ),
                    ),

                    title: Text(
                      member["name"]!,
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      member["usn"]!,
                    ),

                    trailing:
                    const Icon(
                      Icons.chevron_right,
                    ),

                    onTap: () {
                      Navigator.pop(
                        dialogContext,
                      );

                      _transferLeadership(
                        member,
                      );
                    },
                  );
                },
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // TRANSFER LEADERSHIP LOGIC
  // ==========================================================

  void _transferLeadership(
      Map<String, String> newLeader,
      ) {
    setState(() {
      for (final member in members) {
        if (member["status"] == "Leader") {
          member["status"] = "Confirmed";
        }
      }

      newLeader["status"] = "Leader";

      leaderName =
          newLeader["name"] ?? "";
    });

    _showMessage(
      "${newLeader["name"]} is now the group leader.",
    );
  }

  // ==========================================================
  // CLOSE GROUP
  // ==========================================================

  void _showCloseGroupDialog() {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),

          title: const Text(
            "Close Buddy Group?",
            style: TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            "Closing this group will make all active members available for another Buddy Group.",
            style: TextStyle(
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                setState(() {
                  members.clear();
                });

                _showMessage(
                  "Buddy Group #203 has been closed.",
                );

                Future.delayed(
                  const Duration(
                    milliseconds: 700,
                  ),
                      () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor:
                Colors.white,
              ),

              child:
              const Text("Close Group"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // WHITE CARD
  // ==========================================================

  Widget _whiteCard({
    required Widget child,
    EdgeInsets padding =
    const EdgeInsets.all(15),
  }) {
    return Container(
      width: double.infinity,

      padding: padding,

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

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: isError
            ? Colors.red
            : const Color(0xFF16A34A),

        behavior:
        SnackBarBehavior.floating,

        margin:
        const EdgeInsets.all(16),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }
}