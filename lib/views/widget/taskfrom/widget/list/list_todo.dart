import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/controller/task_controller.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_card_item.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit_morevert.dart';
import 'package:get/get.dart';

class TodoList extends StatelessWidget {
  final TaskController taskController;

  TodoList({required this.taskController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (taskController.filteredTodoList.isEmpty) {
        return const Center(child: Text('ไม่มีข้อมูล'));
      } else {
        return ListView(
          children: taskController.filteredTodoList.map((todo) {
            return TaskItem(
              id: todo.userTodoListId,
              title: todo.userTodoListTitle,
              time: todo.userTodoListLastUpdate.toString(),
              description: todo.userTodoListDesc,
              isCompleted: todo.userTodoListCompleted == "true",
              onChanged: (value) {
                taskController.toggleCompletion(todo.userTodoListId, value!);
                print('Selected todo with ID: ${todo.userTodoListId}');
              },
              onEdit: () {
                showTaskEditBottomSheet(
                  context,
                  todo.userTodoListId,
                  todo.userTodoListTitle,
                  todo.userTodoListDesc,
                  todo.userTodoListCompleted == "true", // ส่งค่า completed
                );
              },
            );
          }).toList(),
        );
      }
    });
  }
}
