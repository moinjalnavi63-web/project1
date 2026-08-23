import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {

  final String title;
  final String message;
  final String date;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const CircleAvatar(
                  backgroundColor: Color(0xFFEDE9FE),
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: Color(0xFF5B5FEF),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            const Divider(),

            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 8,
              runSpacing: 8,
              children: [

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_alt_outlined, size: 18),
                  label: const Text("Like"),
                ),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined, size: 18),
                  label: const Text("Comment"),
                ),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: const Text("Share"),
                ),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                  label: const Text("PDF"),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}