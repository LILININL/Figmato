import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/services/deletetask_serveice.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void showTaskEditBottomSheet(BuildContext context, int taskId) {
  showModalBottomSheet(
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
              onTap: () {
                Get.to('/TaskEdit');
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
                await DeleteTaskService.deleteTask(
                    taskId); // เรียกใช้งาน DeleteTaskService;
                Navigator.pop(context); // ปิด bottom sheet
              },
            ),
          ],
        ),
      );
    },
  );
}
