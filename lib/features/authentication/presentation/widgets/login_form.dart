
import 'package:flutter/material.dart';

import '../../../admin/dashboard/pages/admin_dashboard_screen.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../utils/validators.dart';
import '../../../dashboard/student/pages/student_dashboard_screen.dart';
import '../../../dashboard/driver/pages/driver_dashboard_screen.dart';
import '../../../dashboard/faculty/pages/faculty_dashboard_screen.dart';
import '../../../../core/constants/demo_users.dart';
import '../../../../core/constants/registered_users.dart';
import 'login_button.dart';
import 'google_login_button.dart';
import 'auth_footer.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;
  bool isLoading = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Front-end demo data.
  // Later, replace this list with approved institutions from your backend.
  final List<String> institutions = [
    'Kishkinda University',
    'Sample College A (Demo)',
    'Sample University B (Demo)',
  ];

  String? selectedInstitution;

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!widget.formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final email = widget.emailController.text.trim().toLowerCase();
    final password = widget.passwordController.text.trim();

    // Demo admin
    if (email == DemoUsers.adminEmail.trim().toLowerCase() &&
        password == DemoUsers.adminPassword) {
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
        ),
      );
      return;
    }

    // Demo student
    if (email == DemoUsers.studentEmail.trim().toLowerCase() &&
        password == DemoUsers.studentPassword) {
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StudentDashboardScreen(),
        ),
      );
      return;
    }

    // Demo driver
    if (email == DemoUsers.driverEmail.trim().toLowerCase() &&
        password == DemoUsers.driverPassword) {
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DriverDashboardScreen(),
        ),
      );
      return;
    }

    final registeredUser = RegisteredUsers.findUser(
      email: email,
      password: password,
    );

    if (registeredUser != null) {
      setState(() {
        isLoading = false;
      });

      if (registeredUser.role == "Student") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentDashboardScreen(),
          ),
        );
        return;
      }

      if (registeredUser.role == "Driver") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DriverDashboardScreen(),
          ),
        );
        return;
      }

      if (registeredUser.role == "Faculty") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const FacultyDashboardScreen(),
          ),
        );
        return;
      }
    }

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Invalid email or password"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // University / College dropdown
          DropdownButtonFormField<String>(
            initialValue: selectedInstitution,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'University / College',
              hintText: 'Select your institution',
              prefixIcon: const Icon(
                Icons.account_balance_outlined,
                color: Colors.indigo,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.95),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.indigo,
                  width: 2,
                ),
              ),
            ),
            items: institutions.map((institution) {
              return DropdownMenuItem<String>(
                value: institution,
                child: Text(
                  institution,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedInstitution = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your university or college';
              }
              return null;
            },
          ),

          const SizedBox(height: 18),

          // Email field
          CustomTextField(
            controller: widget.emailController,
            label: "Email Address",
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
            focusNode: emailFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),

          const SizedBox(height: 16),

          // Password field
          CustomTextField(
            controller: widget.passwordController,
            label: "Password",
            hintText: "Enter your password",
            prefixIcon: Icons.lock_outline,
            obscureText: obscurePassword,
            validator: Validators.validatePassword,
            focusNode: passwordFocusNode,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (!isLoading) {
                login();
              }
            },
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text("Forgot Password?"),
            ),
          ),

          const SizedBox(height: 10),

          LoginButton(
            isLoading: isLoading,
            onPressed: login,
          ),

          const SizedBox(height: 20),

          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("OR"),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 20),

          const GoogleLoginButton(),

          const SizedBox(height: 20),

          const AuthFooter(),
        ],
      ),
    );
  }
}
