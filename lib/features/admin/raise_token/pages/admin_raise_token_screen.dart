import 'package:flutter/material.dart';

import '../widgets/admin_token_card.dart';
import '../widgets/token_category_filter.dart';
import 'admin_token_details_screen.dart';

class AdminRaiseTokenScreen extends StatefulWidget {
  const AdminRaiseTokenScreen({super.key});

  @override
  State<AdminRaiseTokenScreen> createState() =>
      _AdminRaiseTokenScreenState();
}

class _AdminRaiseTokenScreenState
    extends State<AdminRaiseTokenScreen> {

  String selectedCategory = 'All';
  String selectedStatus = 'All';

  final TextEditingController searchController =
  TextEditingController();

  final List<Map<String, String>> tokens = [
    {
      'id': 'TK001',
      'name': 'Moin',
      'usn': 'KUB24CSE118',
      'category': 'Seat',
      'description':
      'My allocated seat is occupied by another student.',
      'status': 'Pending',
      'bus': 'Bus 1',
      'date': '05 Aug 2026',
      'time': '08:20 AM',
    },
    {
      'id': 'TK002',
      'name': 'Mohammed Mansoor',
      'usn': 'KUB24CSE119',
      'category': 'Bus',
      'description':
      'The bus arrived late at the pickup point.',
      'status': 'In Progress',
      'bus': 'Bus 1',
      'date': '05 Aug 2026',
      'time': '08:45 AM',
    },
    {
      'id': 'TK003',
      'name': 'Rahul Kumar',
      'usn': 'KUB25ECE101',
      'category': 'Driver',
      'description':
      'Driver-related transport issue reported.',
      'status': 'Resolved',
      'bus': 'Bus 2',
      'date': '05 Aug 2026',
      'time': '09:10 AM',
    },
    {
      'id': 'TK004',
      'name': 'Anjali',
      'usn': 'KUB25ISE104',
      'category': 'Route',
      'description':
      'Request to review the current pickup route.',
      'status': 'Pending',
      'bus': 'Bus 2',
      'date': '05 Aug 2026',
      'time': '09:30 AM',
    },
    {
      'id': 'TK005',
      'name': 'Arun',
      'usn': 'KUB26AIML110',
      'category': 'Safety',
      'description':
      'Safety issue reported during transportation.',
      'status': 'Rejected',
      'bus': 'Bus 3',
      'date': '05 Aug 2026',
      'time': '10:00 AM',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // UPDATE TOKEN STATUS
  // ============================================================

  void _updateTokenStatus(
      Map<String, String> token,
      String newStatus,
      ) {
    setState(() {
      token['status'] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _statusColor(newStatus),
        content: Text(
          '${token['id']} status updated to $newStatus',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // STATUS COLOR
  // ============================================================

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;

      case 'In Progress':
        return Colors.blue;

      case 'Resolved':
        return Colors.green;

      case 'Rejected':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  // ============================================================
  // STATUS UPDATE DIALOG
  // ============================================================

  void _showStatusDialog(
      Map<String, String> token,
      ) {
    String currentStatus = token['status'] ?? 'Pending';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Update Token Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${token['id']} • ${token['name']}',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // PENDING
              // ==================================================

              RadioListTile<String>(
                value: 'Pending',
                groupValue: currentStatus,
                activeColor: Colors.orange,
                title: const Text('Pending'),
                onChanged: (value) {
                  if (value == null) return;

                  Navigator.pop(dialogContext);

                  _updateTokenStatus(
                    token,
                    value,
                  );
                },
              ),

              // ==================================================
              // IN PROGRESS
              // ==================================================

              RadioListTile<String>(
                value: 'In Progress',
                groupValue: currentStatus,
                activeColor: Colors.blue,
                title: const Text('In Progress'),
                onChanged: (value) {
                  if (value == null) return;

                  Navigator.pop(dialogContext);

                  _updateTokenStatus(
                    token,
                    value,
                  );
                },
              ),

              // ==================================================
              // RESOLVED
              // ==================================================

              RadioListTile<String>(
                value: 'Resolved',
                groupValue: currentStatus,
                activeColor: Colors.green,
                title: const Text('Resolved'),
                onChanged: (value) {
                  if (value == null) return;

                  Navigator.pop(dialogContext);

                  _updateTokenStatus(
                    token,
                    value,
                  );
                },
              ),

              // ==================================================
              // REJECTED
              // ==================================================

              RadioListTile<String>(
                value: 'Rejected',
                groupValue: currentStatus,
                activeColor: Colors.red,
                title: const Text('Rejected'),
                onChanged: (value) {
                  if (value == null) return;

                  Navigator.pop(dialogContext);

                  _updateTokenStatus(
                    token,
                    value,
                  );
                },
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // FILTERED TOKENS
  // ============================================================

  List<Map<String, String>> get filteredTokens {
    final search =
    searchController.text.trim().toLowerCase();

    return tokens.where((token) {
      final matchesSearch =
          search.isEmpty ||
              token['name']!
                  .toLowerCase()
                  .contains(search) ||
              token['usn']!
                  .toLowerCase()
                  .contains(search) ||
              token['id']!
                  .toLowerCase()
                  .contains(search);

      final matchesCategory =
          selectedCategory == 'All' ||
              token['category'] == selectedCategory;

      final matchesStatus =
          selectedStatus == 'All' ||
              token['status'] == selectedStatus;

      return matchesSearch &&
          matchesCategory &&
          matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredTokens;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Raise Token',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,
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

        child: Column(
          children: [
            // ====================================================
            // SEARCH
            // ====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                10,
              ),
              child: TextField(
                controller: searchController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search token, student or USN',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // ====================================================
            // CATEGORY
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TokenCategoryFilter(
                selectedCategory:
                selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),

            // ====================================================
            // STATUS FILTER
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                decoration: InputDecoration(
                  labelText: 'Token Status',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'All',
                    child: Text('All'),
                  ),
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text('Pending'),
                  ),
                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),
                  DropdownMenuItem(
                    value: 'Resolved',
                    child: Text('Resolved'),
                  ),
                  DropdownMenuItem(
                    value: 'Rejected',
                    child: Text('Rejected'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            // ====================================================
            // TOKEN LIST
            // ====================================================

            Expanded(
              child: filtered.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  30,
                ),
                itemCount: filtered.length,
                itemBuilder: (
                    context,
                    index,
                    ) {
                  final token =
                  filtered[index];

                  return Column(
                    children: [
                      // ==================================================
                      // EXISTING TOKEN CARD
                      // ==================================================

                      AdminTokenCard(
                        tokenId: token['id']!,
                        studentName:
                        token['name']!,
                        usn: token['usn']!,
                        issueCategory:
                        token['category']!,
                        description:
                        token['description']!,
                        status: token['status']!,
                        busNumber: token['bus']!,
                        date: token['date']!,
                        time: token['time']!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AdminTokenDetailsScreen(
                                    token: token,
                                  ),
                            ),
                          );
                        },
                      ),

                      // ==================================================
                      // STATUS UPDATE BUTTON
                      //
                      // Added without modifying AdminTokenCard.
                      // ==================================================

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 0,
                          bottom: 14,
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),

                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        child: Row(
                          children: [
                            Icon(
                              Icons.sync_alt_rounded,
                              size: 19,
                              color:
                              _statusColor(
                                token['status']!,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Current Status',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color:
                                      Colors.grey,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  Text(
                                    token['status']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.bold,
                                      color:
                                      _statusColor(
                                        token['status']!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            OutlinedButton.icon(
                              onPressed: () {
                                _showStatusDialog(
                                  token,
                                );
                              },

                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 17,
                              ),

                              label: const Text(
                                'Update Status',
                              ),

                              style:
                              OutlinedButton.styleFrom(
                                foregroundColor:
                                const Color(
                                  0xff4f46e5,
                                ),
                                side:
                                const BorderSide(
                                  color:
                                  Color(
                                    0xff6366f1,
                                  ),
                                ),
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 14),

            const Text(
              'No Tokens Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Try another category, status or search.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}