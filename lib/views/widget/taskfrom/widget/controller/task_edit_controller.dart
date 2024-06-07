import 'package:fristprofigmatest/services/task_edit_sevice.dart';
import 'package:fristprofigmatest/utils/json/task_edit_jsondata.dart';
import 'package:get/get.dart';

class TaskEditController extends GetxController {
  var taskTitle = ''.obs;
  var taskDescription = ''.obs;
  var taskCompleted = false.obs;
  var userId = ''.obs;

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

  Future<void> saveTask(int taskId) async {
    var jsonData = TaskEditJsonData(
      userTodoListId: taskId.toString(),
      userTodoListTitle: taskTitle.value,
      userTodoListDesc: taskDescription.value,
      userTodoListCompleted: taskCompleted.value.toString(),
      userId: userId.value,
    );

    var result = await TaskEditService.updateTask(jsonData.toJson());
    if (result) {
      Get.back();
    } else {
      Get.snackbar('Error', 'Could not update task');
    }
  }
}
