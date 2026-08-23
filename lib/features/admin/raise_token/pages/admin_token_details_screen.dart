import 'package:flutter/material.dart';

class AdminTokenDetailsScreen extends StatefulWidget {
  final Map<String, String> token;

  const AdminTokenDetailsScreen({
    super.key,
    required this.token,
  });

  @override
  State<AdminTokenDetailsScreen> createState() =>
      _AdminTokenDetailsScreenState();
}

class _AdminTokenDetailsScreenState
    extends State<AdminTokenDetailsScreen> {

  late String status;

  final TextEditingController responseController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    status = widget.token['status'] ?? 'Pending';
  }

  @override
  void dispose() {
    responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = widget.token;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          token['id'] ?? 'Token',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _section(
                title: 'Student Information',
                children: [
                  _info(
                    'Name',
                    token['name'] ?? '-',
                  ),
                  _info(
                    'USN',
                    token['usn'] ?? '-',
                  ),
                  _info(
                    'Bus',
                    token['bus'] ?? '-',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _section(
                title: 'Token Information',
                children: [
                  _info(
                    'Token ID',
                    token['id'] ?? '-',
                  ),
                  _info(
                    'Issue Category',
                    token['category'] ?? '-',
                  ),
                  _info(
                    'Description',
                    token['description'] ?? '-',
                  ),
                  _info(
                    'Date',
                    token['date'] ?? '-',
                  ),
                  _info(
                    'Time',
                    token['time'] ?? '-',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _section(
                title: 'Update Status',
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: InputDecoration(
                      labelText: 'Status',
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
                        status = value;
                      });
                    },
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: responseController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText:
                      'Admin Response / Resolution Remarks',
                      hintText:
                      'Enter your response...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Token updated successfully',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.save_outlined,
                      ),
                      label: const Text(
                        'Update Token',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          ...children,
        ],
      ),
    );
  }

  Widget _info(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}