import 'package:flutter/material.dart';
import '../../../bus_directory/pages/bus_directory_screen.dart';
import '../../../student_directory/pages/student_directory_screen.dart';
class StudentDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const StudentDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 45,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5B5FEF),
                  Color(0xFF7C83FD),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Back Button (Top Left)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onItemSelected(-1);
                  },
                ),

                const SizedBox(height: 15),

                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF5B5FEF),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Mohammed Moinuddin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "KUB24CSE118",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),


          _drawerItem(
            icon: Icons.person_outline,
            title: "Profile",
            index: 1,
          ),

          _drawerItem(
            icon: Icons.directions_bus_outlined,
            title: "Bus Directory",
            index: 2,
          ),

          _drawerItem(
            icon: Icons.event_seat_outlined,
            title: "Seat Allocator",
            index: 3,
          ),

          _drawerItem(
            icon: Icons.groups_outlined,
            title: "Bus Group",
            index: 4,
          ),

          _drawerItem(
            icon: Icons.location_on_outlined,
            title: "Live GPS Tracking",
            index: 5,
          ),

          _drawerItem(
            icon: Icons.confirmation_number_outlined,
            title: "Raise Token",
            index: 6,
          ),



        ListTile(
          selected: selectedIndex == 8,

          selectedTileColor:
          const Color(0xFFEDE9FE),

          leading: Icon(
            Icons.people_outline,

            color: selectedIndex == 8
                ? const Color(0xFF5B5FEF)
                : Colors.black87,
          ),

          title: Text(
            "Student Directory",

            style: TextStyle(
              fontWeight: selectedIndex == 8
                  ? FontWeight.bold
                  : FontWeight.w500,

              color: selectedIndex == 8
                  ? const Color(0xFF5B5FEF)
                  : Colors.black87,
            ),
          ),

          onTap: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                const StudentDirectoryScreen(
                  role: "student",
                ),
              ),
            );
          },
        ),

          const Spacer(),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logout feature coming soon"),
                ),
              );
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected = selectedIndex == index;

    return ListTile(
      selected: selected,
      selectedTileColor: const Color(0xFFEDE9FE),
      leading: Icon(
        icon,
        color: selected
            ? const Color(0xFF5B5FEF)
            : Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight:
          selected ? FontWeight.bold : FontWeight.w500,
          color: selected
              ? const Color(0xFF5B5FEF)
              : Colors.black87,
        ),
      ),
      onTap: () => onItemSelected(index),
    );
  }
}