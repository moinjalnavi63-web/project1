
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../student_directory/pages/student_directory_screen.dart';
import '../../../authentication/presentation/pages/login_screen.dart';
import '../../../profile/student/widgets/student_profile_header.dart';
import '../../../settings/user_settings_screen.dart';

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
// STUDENT PROFILE HEADER
Container(
width: double.infinity,
padding: const EdgeInsets.only(
top: 45,
left: 20,
right: 16,
bottom: 22,
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
// BACK BUTTON
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

const SizedBox(height: 18),

// PHOTO AND STUDENT DETAILS
Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
ValueListenableBuilder<File?>(
valueListenable: studentProfilePhotoNotifier,
builder: (context, photo, child) {
return Container(
width: 70,
height: 70,
padding: const EdgeInsets.all(3),
decoration: const BoxDecoration(
shape: BoxShape.circle,
color: Colors.white,
),
child: ClipOval(
child: photo != null && photo.existsSync()
? Image.file(
photo,
fit: BoxFit.cover,
)
    : const CircleAvatar(
backgroundColor: Colors.white,
child: Icon(
Icons.person,
size: 40,
color: Color(0xFF5B5FEF),
),
),
),
);
},
),

const SizedBox(width: 12),

// STUDENT DETAILS
const Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Mohammed Moinuddin',
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 7),
_StudentDetail(
label: 'ID',
value: 'KUB24CSE118',
),
SizedBox(height: 4),
_StudentDetail(
label: 'Bus No.',
value: 'Bus 01',
),
SizedBox(height: 4),
_StudentDetail(
label: 'Route',
value: 'Hospet Route',
),
SizedBox(height: 4),
_StudentDetail(
label: 'Stop',
value: 'Hospet',
),
],
),
),
],
),
],
),
),

// PROFILE
_drawerItem(
context: context,
icon: Icons.person_outline,
title: 'Profile',
index: 1,
),

// BUS DIRECTORY
_drawerItem(
context: context,
icon: Icons.directions_bus_outlined,
title: 'Bus Directory',
index: 2,
),

// SEAT ALLOCATOR
_drawerItem(
context: context,
icon: Icons.event_seat_outlined,
title: 'Seat Allocator',
index: 3,
),

// BUS GROUP
_drawerItem(
context: context,
icon: Icons.groups_outlined,
title: 'Bus Group',
index: 4,
),

// LIVE GPS
_drawerItem(
context: context,
icon: Icons.location_on_outlined,
title: 'Live GPS Tracking',
index: 5,
),

// RAISE TOKEN
_drawerItem(
context: context,
icon: Icons.confirmation_number_outlined,
title: 'Raise Token',
index: 6,
),

// STUDENT DIRECTORY
ListTile(
selected: selectedIndex == 8,
selectedTileColor: const Color(0xFFEDE9FE),
leading: Icon(
Icons.people_outline,
color: selectedIndex == 8
? const Color(0xFF5B5FEF)
    : Colors.black87,
),
title: Text(
'Student Directory',
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
builder: (_) => const StudentDirectoryScreen(
role: 'student',
),
),
);
},
),

// SETTINGS
ListTile(
leading: const Icon(
Icons.settings_outlined,
color: Colors.black87,
),
title: const Text(
'Settings',
style: TextStyle(
fontWeight: FontWeight.w500,
color: Colors.black87,
),
),
trailing: const Icon(
Icons.chevron_right,
size: 20,
),
onTap: () {
Navigator.pop(context);

Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const UserSettingsScreen(
role: SettingsUserRole.student,
email: '',
phone: '',
),
),
);
},
),

const Spacer(),
const Divider(),

// LOGOUT
ListTile(
leading: const Icon(
Icons.logout,
color: Colors.red,
),
title: const Text(
'Logout',
style: TextStyle(
color: Colors.red,
fontWeight: FontWeight.bold,
),
),
onTap: () {
Navigator.pop(context);
Navigator.of(context).pushAndRemoveUntil(
MaterialPageRoute(
builder: (_) => const LoginScreen(),
),
(route) => false,
);
},
),

const SizedBox(height: 10),
],
),
);
}

// DRAWER MENU ITEM
Widget _drawerItem({
required BuildContext context,
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
fontWeight: selected
? FontWeight.bold
    : FontWeight.w500,
color: selected
? const Color(0xFF5B5FEF)
    : Colors.black87,
),
),
onTap: () {
Navigator.pop(context);
onItemSelected(index);
},
);
}
}

// STUDENT DETAIL TEXT
class _StudentDetail extends StatelessWidget {
final String label;
final String value;

const _StudentDetail({
required this.label,
required this.value,
});

@override
Widget build(BuildContext context) {
return Text(
'$label: $value',
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: Colors.white70,
fontSize: 12,
),
);
}
}