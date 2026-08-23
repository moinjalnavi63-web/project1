import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/login_screen.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../utils/validators.dart';

import '../../providers/register_provider.dart';
import '../../route_list.dart';

import 'identity_selector.dart';
import 'route_dropdown.dart';
import 'register_button.dart';

import '../../../../core/constants/registered_users.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final TextEditingController usnController;
  final TextEditingController idController;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.mobileController,
    required this.usnController,
    required this.idController,
  });

  @override
  ConsumerState<RegisterForm> createState() =>
      _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // =====================================================
          // FULL NAME
          // =====================================================

          CustomTextField(
            controller: widget.nameController,
            label: "Full Name",
            hintText: "Enter your name",
            prefixIcon: Icons.person_outline,
            validator: Validators.validateName,
          ),

          // =====================================================
          // EMAIL
          // =====================================================

          CustomTextField(
            controller: widget.emailController,
            label: "Email Address",
            hintText: "Enter email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),

          // =====================================================
          // PASSWORD
          // =====================================================

          CustomTextField(
            controller: widget.passwordController,
            label: "Password",
            hintText: "Create password",
            prefixIcon: Icons.lock_outline,
            obscureText: !state.passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                state.passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                ref
                    .read(registerProvider.notifier)
                    .togglePassword();
              },
            ),
            validator: Validators.validatePassword,
          ),

          const SizedBox(height: 10),

          // =====================================================
          // IDENTITY
          // =====================================================

          IdentitySelector(
            selectedIdentity: state.selectedIdentity,
            onChanged: (value) {
              ref
                  .read(registerProvider.notifier)
                  .changeIdentity(value);
            },
          ),

          const SizedBox(height: 10),

          // =====================================================
          // STUDENT
          // =====================================================

          if (state.selectedIdentity == "Student") ...[
            RouteDropdown(
              routes: RouteList.routes,
              selectedRoute: state.selectedRoute,
              onChanged: (value) {
                ref
                    .read(registerProvider.notifier)
                    .changeRoute(value);
              },
            ),

            const SizedBox(height: 10),

            CustomTextField(
              controller: widget.usnController,
              label: "USN",
              hintText: "Example KUB24CSE111",
              prefixIcon: Icons.school,
              onChanged: (value) {
                final upperValue = value.toUpperCase();

                widget.usnController.value =
                    widget.usnController.value.copyWith(
                      text: upperValue,
                      selection: TextSelection.collapsed(
                        offset: upperValue.length,
                      ),
                    );
              },
              validator: Validators.validateUSN,
            ),
          ]

          // =====================================================
          // FACULTY
          // =====================================================

          else if (state.selectedIdentity == "Faculty") ...[
            RouteDropdown(
              routes: RouteList.routes,
              selectedRoute: state.selectedRoute,
              onChanged: (value) {
                ref
                    .read(registerProvider.notifier)
                    .changeRoute(value);
              },
            ),

            const SizedBox(height: 10),

            CustomTextField(
              controller: widget.idController,
              label: "Faculty ID",
              hintText: "Enter Faculty ID",
              prefixIcon: Icons.badge_outlined,
              validator: Validators.validateID,
            ),
          ]

          // =====================================================
          // DRIVER
          // =====================================================

          else if (state.selectedIdentity == "Driver") ...[
              CustomTextField(
                controller: widget.mobileController,
                label: "Mobile Number",
                hintText: "Enter mobile number",
                prefixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                validator: Validators.validateMobile,
              ),

              const SizedBox(height: 10),

              CustomTextField(
                controller: widget.idController,
                label: "Driver ID",
                hintText: "Enter Driver ID",
                prefixIcon: Icons.badge_outlined,
                validator: Validators.validateID,
              ),
            ],

          const SizedBox(height: 20),

          // =====================================================
          // REGISTER BUTTON
          // =====================================================

          RegisterButton(
            isLoading: state.isLoading,
            onPressed: () async {
              if (!widget.formKey.currentState!.validate()) {
                return;
              }

              final controller =
              ref.read(registerProvider.notifier);

              controller.setLoading(true);

              await Future.delayed(
                const Duration(seconds: 1),
              );

              // =================================================
              // SAVE REGISTERED USER
              // =================================================

              String identity = state.selectedIdentity;

              String identifier = "";

              if (identity == "Student") {
                identifier =
                    widget.usnController.text.trim().toUpperCase();
              } else {
                identifier =
                    widget.idController.text.trim();
              }

              RegisteredUsers.addUser(
                name: widget.nameController.text.trim(),
                email:
                widget.emailController.text.trim().toLowerCase(),
                password:
                widget.passwordController.text.trim(),
                role: identity,
                identifier: identifier,
                mobile: widget.mobileController.text.trim(),
                route: state.selectedRoute ?? "",
              );

              controller.setLoading(false);

              if (!context.mounted) return;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Text("Success"),
                      ],
                    ),
                    content: Text(
                      "$identity registration completed successfully.",
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 20),

          // =====================================================
          // LOGIN
          // =====================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
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
}