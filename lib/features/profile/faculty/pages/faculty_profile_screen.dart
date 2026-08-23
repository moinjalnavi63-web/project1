import 'package:flutter/material.dart';

class FacultyProfileScreen extends StatelessWidget {
  const FacultyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Color(0xFFD1FAE5),
            Color(0xFFE0E7FF),
            Color(0xFFCFFAFE),
          ],
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Center(
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 55,

                      backgroundColor:
                      Colors.white,

                      child: Icon(
                        Icons.person,
                        size: 60,
                        color:
                        Color(0xFF5B5FEF),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      "Faculty Name",

                      style: TextStyle(
                        fontSize: 25,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const Text(
                      "Faculty ID",

                      style: TextStyle(
                        fontSize: 16,
                        color:
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _infoCard(
                icon: Icons.person_outline,
                title: "Full Name",
                value: "Faculty Name",
              ),

              _infoCard(
                icon: Icons.badge_outlined,
                title: "Faculty ID",
                value: "Faculty ID",
              ),

              _infoCard(
                icon: Icons.email_outlined,
                title: "Email",
                value: "faculty@gmail.com",
              ),
        ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {

    return Container(
      width: double.infinity,

      margin:
      const EdgeInsets.only(bottom: 15),

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(.90),

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.06),

            blurRadius: 12,

            offset:
            const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color:
              const Color(0xFFEDE9FE),

              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color:
              const Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color:
                    Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}