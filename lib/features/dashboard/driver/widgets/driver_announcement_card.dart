import 'package:flutter/material.dart';

class DriverAnnouncementCard extends StatelessWidget {
  const DriverAnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        DriverAnnouncementItem(
          title: "Morning Route",
          description:
          "Please start today's trip at 7:45 AM.",
          date: "Today",
        ),

        SizedBox(height: 15),

        DriverAnnouncementItem(
          title: "Fuel Reminder",
          description:
          "Refuel the assigned bus after today's trip.",
          date: "Yesterday",
        ),

      ],
    );
  }
}

class DriverAnnouncementItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const DriverAnnouncementItem({
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

          Text(description),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text("Send"),
              ),

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Share"),
              ),

            ],
          ),

        ],
      ),
    );
  }
}