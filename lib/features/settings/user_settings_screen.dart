
import 'package:flutter/material.dart';

enum SettingsUserRole {
  admin,
  student,
  faculty,
  driver,
}

class UserSettingsScreen extends StatefulWidget {
  final SettingsUserRole role;

  final String email;
  final String phone;

  final Future<void> Function(String email)? onChangeEmail;
  final Future<void> Function(String phone)? onChangePhone;
  final Future<void> Function(String email)? onResetPassword;
  final Future<void> Function()? onResetApplicationData;

  const UserSettingsScreen({
    super.key,
    required this.role,
    this.email = '',
    this.phone = '',
    this.onChangeEmail,
    this.onChangePhone,
    this.onResetPassword,
    this.onResetApplicationData,
  });

  @override
  State<UserSettingsScreen> createState() =>
      _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  static const Color primary = Color(0xFF5B5FEF);
  static const Color background = Color(0xFFF5F7FC);

  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  bool _busy = false;

  bool get _isAdmin => widget.role == SettingsUserRole.admin;

  String get _roleName {
    switch (widget.role) {
      case SettingsUserRole.admin:
        return 'Admin';
      case SettingsUserRole.student:
        return 'Student';
      case SettingsUserRole.faculty:
        return 'Faculty';
      case SettingsUserRole.driver:
        return 'Driver';
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _message(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _editField({
    required String title,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Future<void> Function(String value)? save,
    required String Function(String value) validate,
  }) async {
    if (_busy) return;

    final input = TextEditingController(text: controller.text);

    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: input,
          autofocus: true,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final text = input.text.trim();
              final error = validate(text);

              if (error.isNotEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(content: Text(error)),
                );
                return;
              }

              Navigator.pop(dialogContext, text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    input.dispose();

    if (value == null || !mounted) return;

    if (save == null) {
      _message('This action is not connected to the backend yet.');
      return;
    }

    setState(() => _busy = true);

    try {
      await save(value);

      if (!mounted) return;

      setState(() => controller.text = value);
      _message('$title completed successfully.');
    } catch (_) {
      _message('$title failed. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resetPassword() async {
    if (_busy) return;

    if (widget.onResetPassword == null) {
      _message('Password reset is not connected to authentication yet.');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _message('Your registered email address is required.');
      return;
    }

    setState(() => _busy = true);

    try {
      await widget.onResetPassword!(
        _emailController.text.trim(),
      );

      _message('Password reset request completed.');
    } catch (_) {
      _message('Unable to reset password. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resetApplicationData() async {
    if (!_isAdmin || _busy) return;

    if (widget.onResetApplicationData == null) {
      _message('Application data reset is not configured.');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 42,
        ),
        title: const Text('Reset Application Data?'),
        content: const Text(
          'This operation may permanently delete application records. '
              'Make sure you have a backup before continuing. '
              'Do you want to proceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm Reset'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _busy = true);

    try {
      await widget.onResetApplicationData!();
      _message('Application data reset completed.');
    } catch (_) {
      _message('Data reset failed. Please contact support.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EF)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEEEEFF),
          child: Icon(icon, color: iconColor ?? primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: _busy ? null : onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('$_roleName Settings'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF20243A),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primary, Color(0xFF8588FF)],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.manage_accounts_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Account & Security',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Manage your $_roleName account settings.',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'ACCOUNT SETTINGS',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _settingTile(
              icon: Icons.email_outlined,
              title: 'Change Email',
              subtitle: _emailController.text.isEmpty
                  ? 'Update your registered email'
                  : _emailController.text,
              onTap: () => _editField(
                title: 'Change Email',
                label: 'New email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                save: widget.onChangeEmail,
                validate: (value) =>
                RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                    .hasMatch(value)
                    ? ''
                    : 'Enter a valid email address.',
              ),
            ),
            _settingTile(
              icon: Icons.phone_outlined,
              title: 'Change Phone Number',
              subtitle: _phoneController.text.isEmpty
                  ? 'Update your registered phone number'
                  : _phoneController.text,
              onTap: () => _editField(
                title: 'Change Phone Number',
                label: 'Phone number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                save: widget.onChangePhone,
                validate: (value) {
                  final digits = value.replaceAll(
                    RegExp(r'\D'),
                    '',
                  );
                  return digits.length >= 10 &&
                      digits.length <= 15
                      ? ''
                      : 'Enter a valid phone number.';
                },
              ),
            ),
            _settingTile(
              icon: Icons.lock_reset_outlined,
              title: 'Reset Password',
              subtitle: 'Request a secure password reset',
              onTap: _resetPassword,
            ),
            if (_isAdmin) ...[
              const SizedBox(height: 16),
              const Text(
                'ADMINISTRATOR',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              _settingTile(
                icon: Icons.delete_forever_outlined,
                title: 'Reset Application Data',
                subtitle: 'Delete application records',
                iconColor: Colors.red,
                onTap: _resetApplicationData,
              ),
            ],
            if (_busy) ...[
              const SizedBox(height: 12),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
