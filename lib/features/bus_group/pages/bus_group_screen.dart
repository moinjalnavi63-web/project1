
import 'package:flutter/material.dart';

class BusGroupScreen extends StatefulWidget {
  final String busName;
  final String routeName;
  final String currentUserName;
  final String currentUserRole;

  const BusGroupScreen({
    super.key,
    required this.busName,
    required this.routeName,
    required this.currentUserName,
    required this.currentUserRole,
  });

  @override
  State<BusGroupScreen> createState() => _BusGroupScreenState();
}

class _ChatMessage {
  final String sender;
  final String role;
  final String message;
  final DateTime time;
  final bool isSystem;

  const _ChatMessage({
    required this.sender,
    required this.role,
    required this.message,
    required this.time,
    this.isSystem = false,
  });
}

class _BusGroupScreenState extends State<BusGroupScreen> {
  final TextEditingController _messageController =
  TextEditingController();

  final ScrollController _scrollController =
  ScrollController();

  late final List<_ChatMessage> _messages;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    _messages = [
      _ChatMessage(
        sender: 'AssistBus',
        role: 'System',
        message: 'Welcome to ${widget.busName} Bus Group.',
        time: now.subtract(const Duration(minutes: 35)),
        isSystem: true,
      ),
      _ChatMessage(
        sender: 'Bus Driver',
        role: 'Driver',
        message: 'Good morning! Please be ready at your pickup stops on time.',
        time: now.subtract(const Duration(minutes: 28)),
      ),
      _ChatMessage(
        sender: 'Student',
        role: 'Student',
        message: 'Thank you, sir.',
        time: now.subtract(const Duration(minutes: 23)),
      ),
      _ChatMessage(
        sender: 'Bus Driver',
        role: 'Driver',
        message: 'I will share an update here if there is a delay.',
        time: now.subtract(const Duration(minutes: 12)),
      ),
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          sender: widget.currentUserName,
          role: widget.currentUserRole,
          message: text,
          time: DateTime.now(),
        ),
      );

      _messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B5FEF);
    const background = Color(0xFFF7F8FC);

    return Column(
      children: [
        // Group information.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFE8EAF2)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.directions_bus_rounded,
                  color: primary,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.busName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.routeName,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.lock_outline_rounded,
                color: Colors.black45,
                size: 20,
              ),
            ],
          ),
        ),

        // Local demo notice.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          color: const Color(0xFFFFF4D9),
          child: const Text(
            'Demo mode: messages are stored only in this screen.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF795A16),
            ),
          ),
        ),

        // Messages.
        Expanded(
          child: Container(
            color: background,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                if (message.isSystem) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9EAF8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555985),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final isMe = message.sender == widget.currentUserName;

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.76,
                    ),
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 8),
                    decoration: BoxDecoration(
                      color: isMe ? primary : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.035),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              '${message.sender} · ${message.role}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                          ),
                        Text(
                          message.message,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.35,
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _formatTime(message.time),
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe
                                  ? Colors.white70
                                  : Colors.black45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Message composer.
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFE8EAF2)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Write a message...',
                      filled: true,
                      fillColor: background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: primary,
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Send message',
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
