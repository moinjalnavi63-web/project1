import 'package:flutter/material.dart';

class FacultyAnnouncementCard extends StatelessWidget {
  const FacultyAnnouncementCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white
            .withValues(alpha: .95),

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: .08),

            blurRadius: 12,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color:
                  const Color(0xFFEDE9FE),

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.campaign_outlined,

                  color:
                  Color(0xFF5B5FEF),

                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Admin Announcement",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "KUTS Administration",
                      style: TextStyle(
                        fontSize: 12,
                        color:
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,

            padding:
            const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color:
              const Color(0xFFF5F3FF),

              borderRadius:
              BorderRadius.circular(14),
            ),

            child: const Text(
              "No new announcements from "
                  "the administration.",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color:
                Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}