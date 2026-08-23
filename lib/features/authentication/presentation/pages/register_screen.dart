import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/register_form.dart';
import '../../providers/register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  ConsumerState<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;

  late Animation<double> fadeAnimation;

  final formKey = GlobalKey<FormState>();

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final mobileController =
  TextEditingController();

  final usnController =
  TextEditingController();

  final idController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(
          vsync: this,
          duration:
          const Duration(milliseconds: 800),
        );

    fadeAnimation =
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeIn,
        );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    usnController.dispose();
    idController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState =
    ref.watch(registerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor:
        Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon:
          const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        width:
        double.infinity,

        decoration:
        const BoxDecoration(
          gradient:
          LinearGradient(
            begin:
            Alignment.topLeft,
            end:
            Alignment.bottomRight,
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],
          ),
        ),

        child:
        SafeArea(
          child:
          FadeTransition(
            opacity:
            fadeAnimation,

            child:
            SingleChildScrollView(
              padding:
              const EdgeInsets.all(24),

              child:
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Create Account",
                    style:
                    TextStyle(
                      fontSize: 32,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Register for Kishkinda University Transport System",
                    style:
                    TextStyle(
                      fontSize: 15,
                      color:
                      Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    padding:
                    const EdgeInsets.all(20),

                    decoration:
                    BoxDecoration(
                      color:
                      Colors.white.withOpacity(.90),
                      borderRadius:
                      BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(.08),
                          blurRadius: 20,
                          offset:
                          const Offset(0, 10),
                        ),
                      ],
                    ),

                    child:
                    RegisterForm(
                      formKey: formKey,
                      nameController:
                      nameController,
                      emailController:
                      emailController,
                      passwordController:
                      passwordController,
                      mobileController:
                      mobileController,
                      usnController:
                      usnController,
                      idController:
                      idController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}