import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/services/deletetask_serveice.dart';
import 'package:get/get.dart';

Future<bool?> showTaskEditBottomSheet(
    BuildContext context, int taskId, String title, String desc) {
  return showModalBottomSheet<bool>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                'assets/icons/Edit.png',
                scale: 1.5,
              ),
              title: const Text(
                'Edit',
                style: TextStyle(color: NotificationColors.dark, fontSize: 16),
              ),
              onTap: () async {
                Get.back(); // ปิด bottom sheet
                final result = await Get.toNamed(
                  '/TaskEdit',
                  parameters: {
                    'taskId': taskId.toString(),
                    'title': title,
                    'desc': desc,
                  },
                );
                Get.back(result: result);
              },
            ),
            const Divider(),
            ListTile(
              leading: Image.asset(
                'assets/icons/Trash.png',
                scale: 1.5,
              ),
              title: const Text(
                'Delete',
                style: TextStyle(color: NotificationColors.dark, fontSize: 16),
              ),
              onTap: () async {
                print(taskId);
                await DeleteTaskService.deleteTask(taskId);
                Get.back(result: true); // ปิด bottom sheet และส่งผลลัพธ์กลับ
              },
            ),
          ],
        ),
      );
    },
  );
}
