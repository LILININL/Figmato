import 'dart:async';
import 'package:fristprofigmatest/services/task_service.dart';
import 'package:fristprofigmatest/utils/json/task_jsondata.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var todoList = <TaskData>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodoList();
  }

  Future<void> fetchTodoList() async {
    try {
      todoList.value = await TaskService.fetchTodoList();
    } on TimeoutException catch (e) {
      print('A timeout : ${e.message}');
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }

  List<TaskData> get filteredTodoList {
    if (searchText.value.isEmpty) {
      return todoList;
    } else {
      return todoList.where((todo) {
        return todo.userTodoListTitle
            .toLowerCase()
            .contains(searchText.value.toLowerCase());
      }).toList();
    }
  }

  void toggleCompletion(int id, bool value) {
    var index = todoList.indexWhere((todo) => todo.userTodoListId == id);
    if (index != -1) {
      todoList[index].userTodoListCompleted = value.toString();
      todoList.refresh();
    }
  }

  void selectAll(bool value) {
    final listToSelect = searchText.value.isEmpty ? todoList : filteredTodoList;
    for (var todo in listToSelect) {
      todo.userTodoListCompleted = value.toString();
    }
    todoList.refresh();
  }
}
