import 'package:fristprofigmatest/utils/json/task_jsondata.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class TaskController extends GetxController {
  var todoList = <TaskData>[].obs;
  var searchText = ''.obs;

  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  @override
  void onInit() {
    fetchTodoList();
    super.onInit();
  }

  void fetchTodoList() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.27.143:6004/api/todo_list/11'),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        todoList.value = data.map((json) => TaskData.fromJson(json)).toList();
      } else {
        print('Failed to load todo list: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load todo list: $e');
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

  void deleteSelectedTodos() {
    final toDelete = todoList.where((todo) => todo.userTodoListCompleted == 'true').toList();
    for (var todo in toDelete) {
      print('Deleting todo with ID: ${todo.userTodoListId}');
      todoList.remove(todo);
    }
    todoList.refresh();
  }
}
