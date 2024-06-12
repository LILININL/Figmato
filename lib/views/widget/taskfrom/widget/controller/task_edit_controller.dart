import 'package:flutter/material.dart';
import 'package:fristprofigmatest/services/task_edit_sevice.dart';
import 'package:get/get.dart';

class TaskEditController extends GetxController {
  var taskTitle = ''.obs;
  var taskDescription = ''.obs;
  var taskCompleted = false.obs;
  var userId = ''.obs;
  var userTodoTypeId = 0.obs; // เพิ่มตัวแปรนี้เพื่อให้ตรงกับ JSON
  var userTodoTypeName = ''.obs; // เพิ่มตัวแปรนี้เพื่อให้ตรงกับ JSON

  void setTitle(String title) {
    taskTitle.value = title;
  }

  void setDescription(String description) {
    taskDescription.value = description;
  }

  void setCompleted(bool completed) {
    taskCompleted.value = completed;
  }

  void setUserId(String id) {
    userId.value = id;
  }

  void setUserTodoTypeId(int id) {
    userTodoTypeId.value = id;
  }

  void setUserTodoTypeName(String name) {
    userTodoTypeName.value = name;
  }

  Future<void> saveTask(
      int taskId, String initialTitle, String initialDesc) async {
    var jsonData = {
      'user_todo_list_id': taskId,
      'user_todo_list_title':
          taskTitle.value.isEmpty ? initialTitle : taskTitle.value,
      'user_todo_list_desc':
          taskDescription.value.isEmpty ? initialDesc : taskDescription.value,
      'user_todo_list_completed': taskCompleted.value.toString(),
      'user_todo_list_last_update': DateTime.now().toIso8601String(),
      'user_id': int.tryParse(userId.value) ?? 0,
      'user_todo_type_id': userTodoTypeId.value,
      'user_todo_type_name': userTodoTypeName.value,
    };

    var result = await TaskEditService.updateTask(jsonData);
    if (result) {
      Get.snackbar(
        'แก้ไขสำเร็จ',
        'แก้ไขและบันทึก Todo สำเร็จ',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(
          '/TaskList',
          arguments: true,
        );
        // ส่งผลลัพธ์กลับเมื่อบันทึกสำเร็จ
      });
    } else {
      Get.snackbar(
        'Error',
        'ไม่สามารถเชื่อมต่อเชิฟเวอร์ได้ !',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
