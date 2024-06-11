import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/services/deletetask_serveice.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/task_list_page.dart';
import 'package:get/get.dart';

Future<bool?> showTaskEditBottomSheet(BuildContext context, int taskId,
    String title, String desc, bool completed) {
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
                    'completed': completed.toString(),
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
                bool confirmDelete = await Get.defaultDialog<bool>(
                      title: "ยืนยันการลบ",
                      middleText: "คุณต้องการลบ Todo นี้หรือไม่?",
                      textConfirm: "ลบ",
                      textCancel: "ยกเลิก",
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                      cancelTextColor: Colors.red,
                      onConfirm: () {
                        Get.back(result: true);
                      },
                      onCancel: () {
                        Get.back(result: false);
                      },
                    ) ??
                    false;

                if (confirmDelete) {
                  try {
                    await DeleteTaskService.deleteTask(taskId);
                    Get.snackbar(
                      'ลบ Todo แล้ว',
                      'ลบ Todo สำเร็จ',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    Get.back(
                        result: true); // ปิด bottom sheet และส่งผลลัพธ์กลับ
                    Get.offAll(() => TaskListPage()); // กลับไปที่หน้า TaskList
                  } catch (e) {
                    Get.snackbar(
                      'ลบ Todo ไม่สำเร็จ',
                      'เกิดข้อผิดพลาดในการลบ Todo',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    Get.back(
                        result: false); // ปิด bottom sheet และส่งผลลัพธ์กลับ
                  }
                } else {
                  Get.back(result: false); // ปิด bottom sheet หากยกเลิก
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
