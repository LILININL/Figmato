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
          const Text(
            'ออกจากระบบ',
            style: TextStyle(color: NotificationColors.dark, fontSize: 18),
          ),
          const Text(
            'คุณต้องการออกจากระบบ ?',
            style: TextStyle(color: NotificationColors.dark, fontSize: 16),
          ),
          const SizedBox(
            height: 16,
            width: 0,
          ),
          ListTile(
            leading: Image.asset('assets/icons/Logout.png'),
            title: const Text(
              'ออกจากระบบ',
              style: TextStyle(color: NotificationColors.dark, fontSize: 16),
            ),
            onTap: _signOut,
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
