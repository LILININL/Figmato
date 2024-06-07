import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:get/get.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white, // กำหนดสีพื้นหลัง
          title: const Text('ยืนยันการออกจากแอพ'),
          content: const Text('คุณต้องการออกจากแอพหรือไม่?'),
          shape: RoundedRectangleBorder(
            // กำหนดรูปร่างของกล่อง dialog
            borderRadius: BorderRadius.circular(10),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text(
                'ยกเลิก',
                style: TextStyle(color: NotificationColors.dark),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text(
                'ตกลง',
                style: TextStyle(color: NotificationColors.dark),
              ),
            ),
          ],
        ),
      )) ??
      false;
}
