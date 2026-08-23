import 'package:flutter/material.dart';
import '../../../models/identity_type.dart';

class RegisterController {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final mobileController = TextEditingController();

  final usnController = TextEditingController();

  final idController = TextEditingController();

  IdentityType selectedIdentity = IdentityType.student;
  String? selectedRoute;

  bool hidePassword = true;

  bool isLoading = false;

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    usnController.dispose();
    idController.dispose();
  }
}