import 'package:flutter/material.dart';

class StudentAnnouncementCard extends StatelessWidget {
  const StudentAnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        AnnouncementItem(
          title: "Route Updated",
          description:
          "Morning bus timing changed from 8:00 AM to 8:15 AM.",
          date: "Today",
        ),

        SizedBox(height: 15),

        AnnouncementItem(
          title: "Holiday Notice",
          description:
          "University buses will not operate this Sunday.",
          date: "Yesterday",
        ),

      ],
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const AnnouncementItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              const Icon(
                Icons.campaign,
                color: Color(0xFF5B5FEF),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

            ],
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              height: 1.4,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined),
                label: const Text("View"),
              ),

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
                label: const Text("Share"),
              ),

            ],
          ),

        ],
      ),
    );
  }
}