import 'package:flutter/material.dart';
import 'create_buddy_group_screen.dart';

class BuddySystemScreen extends StatefulWidget {
  const BuddySystemScreen({super.key});

  @override
  State<BuddySystemScreen> createState() => _BuddySystemScreenState();
}

class _BuddySystemScreenState extends State<BuddySystemScreen> {
  bool hasBuddyGroup = false;
  bool hasPendingRequest = true;

  // ==========================================================
  // CURRENT USER
  // ==========================================================

  final String currentUserName = "Mohammed Moinuddin";
  final String currentUserId = "KUB24CSE118";

  // ==========================================================
  // BUDDY GROUP MEMBERS
  // ==========================================================

  List<Map<String, String>> members = [
    {
      "name": "Mohammed Moinuddin",
      "id": "KUB24CSE118",
      "status": "Leader",
    },
    {
      "name": "Mansoor",
      "id": "KUB24CSE120",
      "status": "Confirmed",
    },
    {
      "name": "Owais",
      "id": "KUB24CSE125",
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
          "Buddy System",
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
                _buildHeader(),

                const SizedBox(height: 18),

                _buildQuickActions(),

                const SizedBox(height: 18),

                if (hasBuddyGroup)
                  _buildMyBuddyGroup()
                else
                  _buildNoGroupCard(),

                const SizedBox(height: 18),

                _buildWeeklyProgress(),

                const SizedBox(height: 18),

                _buildCurrentAllocation(),

                const SizedBox(height: 18),

                _buildWeeklyHistory(),

                const SizedBox(height: 18),

                _buildInformationCard(),
              ],
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B5FEF).withOpacity(.25),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "🤝",
                style: TextStyle(
                  fontSize: 34,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buddy System",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Travel and sit together with your friends.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  "Maximum 3 students per group",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
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
  // QUICK ACTIONS
  // ==========================================================

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            icon: Icons.group_add_rounded,
            title: "Create Group",
            subtitle: "Add friends",
            color: const Color(0xFF7C3AED),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateBuddyGroupScreen(),
                ),
              );

              if (result != null &&
                  result is Map &&
                  result["success"] == true) {
                setState(() {
                  hasBuddyGroup = true;
                  hasPendingRequest = false;

                  members = [
                    {
                      "name": currentUserName,
                      "id": currentUserId,
                      "status": "Leader",
                    },
                    {
                      "name": result["friend1"] ?? "Friend 1",
                      "id": _generateDemoId(result["friend1"]),
                      "status": "Confirmed",
                    },
                  ];

                  final friend2 =
                  (result["friend2"] ?? "").toString().trim();

                  if (friend2.isNotEmpty) {
                    members.add({
                      "name": friend2,
                      "id": _generateDemoId(friend2),
                      "status": "Confirmed",
                    });
                  }
                });

                _showSuccessMessage(
                  "Buddy Group created successfully.",
                );
              }
            },
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _actionCard(
            icon: Icons.mail_outline_rounded,
            title: "Requests",
            subtitle:
            hasPendingRequest ? "1 pending" : "No requests",
            color: const Color(0xFFEC4899),
            onTap: () {
              _showRequestDialog();
            },
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _actionCard(
            icon: Icons.calendar_month_rounded,
            title: "Schedule",
            subtitle: "This week",
            color: const Color(0xFF0891B2),
            onTap: () {
              _showScheduleDialog();
            },
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: color.withOpacity(.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // NO GROUP
  // ==========================================================

  Widget _buildNoGroupCard() {
    return _whiteCard(
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFEDE9FE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "👥",
                style: TextStyle(
                  fontSize: 34,
                ),
              ),
            ),
          ),

          const SizedBox(height: 13),

          const Text(
            "You are not in a Buddy Group",
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Use the Create Group button above to create a group with 1 or 2 friends.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MY GROUP
  // ==========================================================

  Widget _buildMyBuddyGroup() {
    return _whiteCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Buddy Group",
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Group #203",
                      style: TextStyle(
                        color: Color(0xFF5B5FEF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              _statusBadge(
                "Active",
                const Color(0xFF16A34A),
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Divider(height: 1),

          const SizedBox(height: 12),

          Row(
            children: [
              const Expanded(
                child: Text(
                  "Members",
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "${members.length}/3",
                style: const TextStyle(
                  color: Color(0xFF5B5FEF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          ...members.map(
                (member) => _memberCard(member),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _showManageGroupDialog,
                  icon: const Icon(
                    Icons.settings_outlined,
                    size: 18,
                  ),
                  label: const Text("Manage"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF5B5FEF),
                    side: const BorderSide(
                      color: Color(0xFF5B5FEF),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _showLeaveGroupDialog,
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    size: 18,
                  ),
                  label: const Text("Leave Group"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(
                      color: Colors.red,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
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
    final bool leader =
        member["status"] == "Leader";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: leader
              ? const Color(0xFFD8B4FE)
              : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: leader
                ? const Color(0xFFEDE9FE)
                : const Color(0xFFE0F2FE),
            child: Icon(
              leader
                  ? Icons.star_rounded
                  : Icons.person_rounded,
              color: leader
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
                  member["name"]!,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  member["id"]!,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),

          _statusBadge(
            member["status"]!,
            leader
                ? const Color(0xFF7C3AED)
                : const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MANAGE GROUP
  // ==========================================================

  void _showManageGroupDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Manage Buddy Group",
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${members.length}/3 members",
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 18),

                // ADD FRIEND
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  tileColor: const Color(0xFFF5F3FF),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEDE9FE),
                    child: Icon(
                      Icons.person_add_alt_1,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  title: const Text(
                    "Add Friend",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Add another student to your group",
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showAddFriendDialog();
                  },
                ),

                const SizedBox(height: 10),

                // REMOVE FRIEND
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  tileColor: const Color(0xFFFFF7ED),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFFFEDD5),
                    child: Icon(
                      Icons.person_remove_outlined,
                      color: Color(0xFFEA580C),
                    ),
                  ),
                  title: const Text(
                    "Remove Friend",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Remove a member from the group",
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showRemoveFriendDialog();
                  },
                ),

                const SizedBox(height: 10),

                // TRANSFER LEADERSHIP
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  tileColor: const Color(0xFFF5F3FF),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEDE9FE),
                    child: Icon(
                      Icons.swap_horiz_rounded,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  title: const Text(
                    "Transfer Leadership",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Make another member the group leader",
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showTransferLeadershipDialog();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // ADD FRIEND
  // ==========================================================

  void _showAddFriendDialog() {
    if (members.length >= 3) {
      _showErrorMessage(
        "Buddy Group is full. Maximum 3 students allowed.",
      );
      return;
    }

    final nameController = TextEditingController();
    final idController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.person_add_alt_1,
                color: Color(0xFF7C3AED),
              ),
              SizedBox(width: 9),
              Text(
                "Add Friend",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add a student to your Buddy Group.",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: nameController,
                textCapitalization:
                TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(13),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: idController,
                textCapitalization:
                TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: "USN",
                  hintText: "KUB24CSE120",
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
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
                final name =
                nameController.text.trim();
                final id =
                idController.text.trim().toUpperCase();

                if (name.isEmpty || id.isEmpty) {
                  _showErrorMessage(
                    "Enter both student name and USN.",
                  );
                  return;
                }

                final alreadyExists =
                members.any(
                      (member) =>
                  member["id"]!
                      .toLowerCase() ==
                      id.toLowerCase(),
                );

                if (alreadyExists) {
                  _showErrorMessage(
                    "This student is already in the group.",
                  );
                  return;
                }

                setState(() {
                  members.add({
                    "name": name,
                    "id": id,
                    "status": "Confirmed",
                  });
                });

                Navigator.pop(dialogContext);

                _showSuccessMessage(
                  "$name added to Buddy Group.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF5B5FEF),
                foregroundColor: Colors.white,
              ),
              child: const Text("Add"),
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
    final removableMembers = members
        .where(
          (member) =>
      member["id"] != currentUserId &&
          member["status"] != "Leader",
    )
        .toList();

    if (removableMembers.isEmpty) {
      _showErrorMessage(
        "There are no removable members.",
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.person_remove_outlined,
                color: Color(0xFFEA580C),
              ),
              SizedBox(width: 9),
              Text(
                "Remove Friend",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select the member you want to remove.",
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ...removableMembers.map(
                    (member) => Container(
                  margin:
                  const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius:
                    BorderRadius.circular(13),
                    border: Border.all(
                      color: const Color(0xFFFED7AA),
                    ),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor:
                      Color(0xFFFFEDD5),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFFEA580C),
                      ),
                    ),
                    title: Text(
                      member["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      member["id"]!,
                    ),
                    trailing: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.pop(dialogContext);
                      _confirmRemoveFriend(member);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmRemoveFriend(
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
            "Remove ${member["name"]} from Buddy Group #203?",
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
                setState(() {
                  members.removeWhere(
                        (item) =>
                    item["id"] == member["id"],
                  );
                });

                Navigator.pop(dialogContext);

                _showSuccessMessage(
                  "${member["name"]} removed from the group.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Remove"),
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
    final currentLeader = members.firstWhere(
          (member) => member["status"] == "Leader",
      orElse: () => {},
    );

    if (currentLeader["id"] != currentUserId) {
      _showErrorMessage(
        "Only the current group leader can transfer leadership.",
      );
      return;
    }

    final otherMembers = members
        .where(
          (member) =>
      member["id"] != currentUserId,
    )
        .toList();

    if (otherMembers.isEmpty) {
      _showErrorMessage(
        "You need another member to transfer leadership.",
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.swap_horiz_rounded,
                color: Color(0xFF7C3AED),
              ),
              SizedBox(width: 9),
              Text(
                "Transfer Leadership",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose a member to become the new leader.",
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ...otherMembers.map(
                    (member) => Container(
                  margin:
                  const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius:
                    BorderRadius.circular(13),
                    border: Border.all(
                      color: const Color(0xFFE9D5FF),
                    ),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor:
                      Color(0xFFEDE9FE),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                    title: Text(
                      member["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      member["id"]!,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0xFF7C3AED),
                    ),
                    onTap: () {
                      Navigator.pop(dialogContext);
                      _confirmTransferLeadership(
                        member,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmTransferLeadership(
      Map<String, String> newLeader,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Transfer Leadership?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Make ${newLeader["name"]} the new leader of Buddy Group #203?",
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
                setState(() {
                  for (final member in members) {
                    member["status"] =
                    member["id"] == newLeader["id"]
                        ? "Leader"
                        : "Confirmed";
                  }
                });

                Navigator.pop(dialogContext);

                _showSuccessMessage(
                  "${newLeader["name"]} is now the group leader.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
              ),
              child: const Text("Transfer"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // LEAVE GROUP
  // ==========================================================

  void _showLeaveGroupDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Leave Buddy Group?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "You will become available to join another Buddy Group.",
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
                  hasBuddyGroup = false;
                  members = [
                    {
                      "name": currentUserName,
                      "id": currentUserId,
                      "status": "Leader",
                    },
                  ];
                });

                _showSuccessMessage(
                  "You left the Buddy Group.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Leave"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // REQUEST DIALOG
  // ==========================================================

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            "Buddy Request",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                "Mansoor invited you to join:",
              ),
              SizedBox(height: 12),
              Text(
                "Buddy Group #203",
                style: TextStyle(
                  color: Color(0xFF5B5FEF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Members:\n"
                    "• Mansoor\n"
                    "• Mohammed Moinuddin\n"
                    "• Owais",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  hasPendingRequest = false;
                });
              },
              child: const Text(
                "Decline",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  hasBuddyGroup = true;
                  hasPendingRequest = false;

                  members = [
                    {
                      "name": currentUserName,
                      "id": currentUserId,
                      "status": "Confirmed",
                    },
                    {
                      "name": "Mansoor",
                      "id": "KUB24CSE120",
                      "status": "Leader",
                    },
                    {
                      "name": "Owais",
                      "id": "KUB24CSE125",
                      "status": "Confirmed",
                    },
                  ];
                });

                _showSuccessMessage(
                  "Buddy request accepted.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF16A34A),
                foregroundColor: Colors.white,
              ),
              child: const Text("Accept"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // SCHEDULE
  // ==========================================================

  void _showScheduleDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                "Weekly Schedule",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Buddy seating plan",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 18),

              ...[
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
              ].asMap().entries.map(
                    (entry) {
                  final bool together =
                      entry.key != 2 &&
                          entry.key != 4;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      entry.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Chip(
                      label: Text(
                        together
                            ? "Together"
                            : "Rotation",
                      ),
                      backgroundColor: together
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFEDE9FE),
                      labelStyle: TextStyle(
                        color: together
                            ? const Color(0xFF15803D)
                            : const Color(0xFF6D28D9),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // WEEKLY PROGRESS
  // ==========================================================

  Widget _buildWeeklyProgress() {
    const int togetherDays = 3;
    const int targetDays = 3;

    return _whiteCard(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  color: Color(0xFF16A34A),
                  size: 21,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weekly Buddy Progress",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Goal: sit together at least 3 days",
                      style: TextStyle(
                        color: Color(0xFF4B5563),
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
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 1,
              minHeight: 10,
              backgroundColor:
              Color(0xFFE5E7EB),
              valueColor:
              AlwaysStoppedAnimation(
                Color(0xFF22C55E),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Together days",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 11,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: const Text(
                  "Requirement Achieved ✓",
                  style: TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
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
    if (!hasBuddyGroup) {
      return _whiteCard(
        child: const Row(
          children: [
            Icon(
              Icons.event_seat_outlined,
              color: Color(0xFF9CA3AF),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Create or join a Buddy Group to see your buddy seat allocation.",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

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
                  "Current Buddy Allocation",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              _statusBadge(
                "Together",
                const Color(0xFF16A34A),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
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
              children: members
                  .take(3)
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (entry) => Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.only(
                      right:
                      entry.key <
                          members
                              .take(
                            3,
                          )
                              .length -
                              1
                          ? 8
                          : 0,
                    ),
                    child: _seatBox(
                      entry.value["name"]!,
                      "${21 + entry.key}",
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF5B5FEF),
                size: 15,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Your group is currently sitting together.",
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 10.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seatBox(
      String name,
      String seat,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
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
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // WEEKLY HISTORY
  // ==========================================================

  Widget _buildWeeklyHistory() {
    final days = [
      ["Monday", true],
      ["Tuesday", true],
      ["Wednesday", false],
      ["Thursday", true],
      ["Friday", false],
    ];

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
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          ...days.map(
                (day) => Padding(
              padding:
              const EdgeInsets.only(
                bottom: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      day[0] as String,
                      style: const TextStyle(
                        color: Color(0xFF374151),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    day[1] as bool
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: day[1] as bool
                        ? const Color(0xFF16A34A)
                        : const Color(0xFF9CA3AF),
                    size: 19,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    day[1] as bool
                        ? "Together"
                        : "Separate",
                    style: TextStyle(
                      color: day[1] as bool
                          ? const Color(0xFF15803D)
                          : const Color(0xFF6B7280),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
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

  // ==========================================================
  // INFORMATION
  // ==========================================================

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(17),
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
                "Buddy System Rules",
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
            "• A group can contain 2–3 students.\n"
                "• You can belong to only one active group.\n"
                "• Attendance must be confirmed before receiving a seat.\n"
                "• The system tries to keep buddies together.\n"
                "• Buddy seating target is at least 3 days per week.\n"
                "• Seat positions can rotate between weeks.",
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
  // COMMON WHITE CARD
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
        borderRadius: BorderRadius.circular(19),
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
      padding: const EdgeInsets.symmetric(
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
  // SUCCESS MESSAGE
  // ==========================================================

  void _showSuccessMessage(
      String message,
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
        backgroundColor:
        const Color(0xFF16A34A),
        behavior:
        SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ==========================================================
  // ERROR MESSAGE
  // ==========================================================

  void _showErrorMessage(
      String message,
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
        backgroundColor: Colors.red,
        behavior:
        SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ==========================================================
  // DEMO ID GENERATOR
  // ==========================================================

  String _generateDemoId(dynamic value) {
    final text =
    (value ?? "").toString().trim();

    if (text.toLowerCase().contains("mansoor")) {
      return "KUB24CSE120";
    }

    if (text.toLowerCase().contains("owais")) {
      return "KUB24CSE125";
    }

    return "KUB24CSE${120 + members.length}";
  }
}