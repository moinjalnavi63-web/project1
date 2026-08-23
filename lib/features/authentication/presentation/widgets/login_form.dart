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
  State<LoginForm> createState() =>
      _LoginFormState();
}

class _LoginFormState
    extends State<LoginForm> {

  bool obscurePassword = true;
  bool isLoading = false;

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login() async {
    if (!widget.formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    final email =
    widget.emailController.text
        .trim()
        .toLowerCase();

    final password =
    widget.passwordController.text.trim();

    // ========================================================
    // DEMO ADMIN
    // ========================================================

    if (email ==
        DemoUsers.adminEmail
            .trim()
            .toLowerCase() &&
        password == DemoUsers.adminPassword) {

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const AdminDashboardScreen(),
        ),
      );

      return;
    }

    // ========================================================
    // DEMO STUDENT
    // ========================================================

    if (email ==
        DemoUsers.studentEmail
            .trim()
            .toLowerCase() &&
        password == DemoUsers.studentPassword) {

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const StudentDashboardScreen(),
        ),
      );

      return;
    }

    // ========================================================
    // DEMO DRIVER
    // ========================================================

    if (email ==
        DemoUsers.driverEmail
            .trim()
            .toLowerCase() &&
        password == DemoUsers.driverPassword) {

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const DriverDashboardScreen(),
        ),
      );

      return;
    }

    // ========================================================
    // REGISTERED USER
    // ========================================================

    final registeredUser =
    RegisteredUsers.findUser(
      email: email,
      password: password,
    );

    if (registeredUser != null) {

      setState(() {
        isLoading = false;
      });

      // ======================================================
      // STUDENT
      // ======================================================

      if (registeredUser.role == "Student") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const StudentDashboardScreen(),
          ),
        );

        return;
      }

      // ======================================================
      // DRIVER
      // ======================================================

      if (registeredUser.role == "Driver") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const DriverDashboardScreen(),
          ),
        );

        return;
      }

      // ======================================================
      // FACULTY
      // ======================================================

      if (registeredUser.role == "Faculty") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const FacultyDashboardScreen(),
          ),
        );

        return;
      }
    }

    // ========================================================
    // INVALID LOGIN
    // ========================================================

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Invalid email or password",
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,

      child: Column(
        children: [

          CustomTextField(
            controller:
            widget.emailController,

            label:
            "Email Address",

            hintText:
            "Enter your email",

            prefixIcon:
            Icons.email_outlined,

            keyboardType:
            TextInputType.emailAddress,

            validator:
            Validators.validateEmail,
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller:
            widget.passwordController,

            label:
            "Password",

            hintText:
            "Enter your password",

            prefixIcon:
            Icons.lock_outline,

            obscureText:
            obscurePassword,

            validator:
            Validators.validatePassword,

            suffixIcon:
            IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword =
                  !obscurePassword;
                });
              },
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment:
            Alignment.centerRight,

            child: TextButton(
              onPressed: () {},

              child: const Text(
                "Forgot Password?",
              ),
            ),
          ),

          const SizedBox(height: 10),

          LoginButton(
            isLoading:
            isLoading,
            onPressed:
            login,
          ),

          const SizedBox(height: 20),

          const Row(
            children: [
              Expanded(
                child: Divider(),
              ),

              Padding(
                padding:
                EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text("OR"),
              ),

              Expanded(
                child: Divider(),
              ),
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