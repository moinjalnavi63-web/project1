
import 'package:flutter/material.dart';

import '../../../authentication/route_list.dart';
import '../../../../core/constants/registered_users.dart';
import '../../../authentication/presentation/pages/login_screen.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final TextEditingController usnController;
  final TextEditingController idController;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.mobileController,
    required this.usnController,
    required this.idController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _identityIdFocus = FocusNode();

  String? _selectedIdentity;
  String? _selectedBus;
  String? _selectedStop;

  bool _isLoading = false;
  bool _obscurePassword = true;

  static const Color _blue = Color(0xFF5965F5);
  static const Color _teal = Color(0xFF10B9A8);
  static const Color _textColor = Color(0xFF24334B);

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _mobileFocus.dispose();
    _identityIdFocus.dispose();
    super.dispose();
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF64748B)),
      prefixIcon: Icon(icon, color: _blue, size: 21),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFF),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: _blue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction:
      nextFocus == null ? TextInputAction.done : TextInputAction.next,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      decoration: _decoration(
        label: label,
        icon: icon,
        suffixIcon: suffixIcon,
      ),
      validator: validator ??
              (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          },
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }

  Widget _buildIdentityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedIdentity,
      isExpanded: true,
      decoration: _decoration(
        label: 'Select Identity',
        icon: Icons.badge_outlined,
      ),
      hint: const Text('Choose your identity'),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: const [
        DropdownMenuItem(value: 'Student', child: Text('Student')),
        DropdownMenuItem(value: 'Faculty', child: Text('Faculty')),
        DropdownMenuItem(value: 'Driver', child: Text('Driver')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your identity';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _selectedIdentity = value;
          widget.usnController.clear();
          widget.idController.clear();
        });
      },
    );
  }

  Widget _buildIdentityIdField() {
    if (_selectedIdentity == null) {
      return const SizedBox.shrink();
    }

    final bool isStudent = _selectedIdentity == 'Student';
    final TextEditingController controller =
    isStudent ? widget.usnController : widget.idController;

    final String label = switch (_selectedIdentity) {
      'Student' => 'Student ID / USN',
      'Faculty' => 'Faculty ID',
      'Driver' => 'Driver ID',
      _ => 'ID',
    };

    return TextFormField(
      controller: controller,
      focusNode: _identityIdFocus,
      textCapitalization: TextCapitalization.characters,
      decoration: _decoration(
        label: label,
        icon: Icons.credit_card_outlined,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildBusDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBus,
      isExpanded: true,
      decoration: _decoration(
        label: 'Select Bus Number',
        icon: Icons.directions_bus_outlined,
      ),
      hint: const Text('Choose your bus'),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: RouteList.buses.map((bus) {
        return DropdownMenuItem<String>(
          value: bus.busNumber,
          child: Text(
            '${bus.busNumber} — ${bus.routeName}',
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a bus';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _selectedBus = value;
          _selectedStop = null;
        });
      },
    );
  }

  Widget _buildStopDropdown() {
    final BusRoute? selectedBus = RouteList.findBus(_selectedBus);

    if (selectedBus == null) {
      return const SizedBox.shrink();
    }

    return DropdownButtonFormField<String>(
      value: _selectedStop,
      isExpanded: true,
      decoration: _decoration(
        label: 'Select Bus Stop',
        icon: Icons.location_on_outlined,
      ),
      hint: const Text('Choose your boarding stop'),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: selectedBus.stops.map((stop) {
        return DropdownMenuItem<String>(
          value: stop,
          child: Text(stop, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your boarding stop';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _selectedStop = value;
        });
      },
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_blue, _teal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _blue.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
          width: 23,
          height: 23,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_alt_1_rounded, size: 19),
            SizedBox(width: 9),
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInOption() {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 4),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'Already have an account? ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: _blue,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final BusRoute? selectedBus = RouteList.findBus(_selectedBus);

      if (selectedBus == null || _selectedStop == null) {
        return;
      }

      final bool isStudent = _selectedIdentity == 'Student';
      final String identifier = isStudent
          ? widget.usnController.text.trim()
          : widget.idController.text.trim();

      final bool success = RegisteredUsers.addUser(
        name: widget.nameController.text.trim(),
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text,
        role: _selectedIdentity!,
        identifier: identifier,
        mobile: widget.mobileController.text.trim(),
        route: selectedBus.routeName,
        busNo: selectedBus.busNumber,
        stop: _selectedStop!,
      );

      if (!mounted) return;

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An account with this email already exists.'),
          ),
        );
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            title: const Text(
              'Registration Successful',
              style: TextStyle(
                color: _textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Your account has been registered as $_selectedIdentity.\n\n'
                  'Bus: ${selectedBus.busNumber}\n'
                  'Route: ${selectedBus.routeName}\n'
                  'Stop: $_selectedStop',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: _blue),
                ),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const LoginScreen(),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _textField(
            controller: widget.nameController,
            label: 'Full Name',
            icon: Icons.person_outline_rounded,
            focusNode: _nameFocus,
            nextFocus: _emailFocus,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          _textField(
            controller: widget.emailController,
            label: 'Email Address',
            icon: Icons.email_outlined,
            focusNode: _emailFocus,
            nextFocus: _passwordFocus,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  .hasMatch(value.trim())) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _textField(
            controller: widget.passwordController,
            label: 'Password',
            icon: Icons.lock_outline_rounded,
            focusNode: _passwordFocus,
            nextFocus: _mobileFocus,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              tooltip: _obscurePassword ? 'Show password' : 'Hide password',
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF64748B),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _textField(
            controller: widget.mobileController,
            label: 'Mobile Number',
            icon: Icons.phone_outlined,
            focusNode: _mobileFocus,
            nextFocus: _identityIdFocus,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Mobile number is required';
              }
              if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                return 'Enter a valid 10-digit mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildIdentityDropdown(),
          const SizedBox(height: 16),
          _buildIdentityIdField(),
          if (_selectedIdentity != null) const SizedBox(height: 16),
          _buildBusDropdown(),
          const SizedBox(height: 16),
          _buildStopDropdown(),
          const SizedBox(height: 24),
          _buildRegisterButton(),

          // Sign-in option is now inside the form.
          _buildSignInOption(),
        ],
      ),
    );
  }
}
