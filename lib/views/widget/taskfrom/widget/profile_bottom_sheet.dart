import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ลบข้อมูลทั้งหมดใน SharedPreferences

    Get.offAllNamed('/login'); // เปลี่ยนหน้าไปที่ /login
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.only(
                bottom: 10), // Adding some margin at the bottom
          ),
          const Text(
            'SIGN OUT',
            style: TextStyle(
                color: NotificationColors.dark,
                fontSize: 20, // Font size in pixels
                height: 1.26,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
            width: 0,
          ),
          const Text(
            'Do you want to log out?',
            style: TextStyle(
                color: NotificationColors.dark,
                fontSize: 16, // Font size in pixels
                height: 1.26,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
            width: 0,
          ),
          ListTile(
            leading: Image.asset(
                'assets/icons/Logout.png'), // Custom icon for signout
            title: const Text(
              'Signout',
              style: TextStyle(color: NotificationColors.dark, fontSize: 16),
            ),
            trailing: Image.asset(
                'assets/icons/arrowright2.png'), // Custom arrow on the right side
            onTap: _signOut,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 1,
              color: Colors.grey[400], // Green divider line
            ),
          ),
        ],
      ),
    );
  }
}

void showProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return const ProfileBottomSheet();
    },
  );
}
