import 'package:flutter/material.dart';

class StudentProfileCard extends StatelessWidget {
  final String name;
  final String usn;
  final String branch;
  final String year;
  final String busNumber;
  final String pickupStop;
  final String seatNumber;

  final VoidCallback onOpenProfile;

  const StudentProfileCard({
    super.key,
    required this.name,
    required this.usn,
    required this.branch,
    required this.year,
    required this.busNumber,
    required this.pickupStop,
    required this.seatNumber,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(
          children: [

            // ==========================
            // PROFILE
            // ==========================

            CircleAvatar(
              radius: 27,
              backgroundColor: const Color(0xffe0e7ff),
              child: Text(
                name.isNotEmpty
                    ? name[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(width: 13),

            // ==========================
            // STUDENT SUMMARY
            // ==========================

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    usn,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Wrap(
                    spacing: 6,
                    runSpacing: 5,
                    children: [

                      _infoChip(
                        '$branch',
                        Icons.school_outlined,
                      ),

                      _infoChip(
                        year,
                        Icons.calendar_today_outlined,
                      ),

                      _infoChip(
                        busNumber,
                        Icons.directions_bus_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ==========================
            // OPEN PROFILE BUTTON
            // ==========================

            Material(
              color: const Color(0xffede9fe),
              borderRadius: BorderRadius.circular(14),

              child: InkWell(
                borderRadius: BorderRadius.circular(14),

                onTap: onOpenProfile,

                child: const Padding(
                  padding: EdgeInsets.all(10),

                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.deepPurple,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(
      String text,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 12,
            color: Colors.deepPurple,
          ),

          const SizedBox(width: 3),

          Text(
            text,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}