import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/controller/task_edit_controller.dart';
import 'package:get/get.dart';

class TaskEditPage extends StatelessWidget {
  final int taskId;
  final String initialTitle;
  final String initialDescription;

  TaskEditPage({
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
    required initialCompleted, required userId,
  });

  @override
  Widget build(BuildContext context) {
    final TaskEditController controller = Get.put(TaskEditController());

    // Set initial values
    controller.setTitle(initialTitle);
    controller.setDescription(initialDescription);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: initialTitle),
              decoration: InputDecoration(labelText: 'Task Title'),
              onChanged: (value) => controller.setTitle(value),
            ),
            TextField(
              controller: TextEditingController(text: initialDescription),
              decoration: InputDecoration(labelText: 'Task Description'),
              onChanged: (value) => controller.setDescription(value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.saveTask(taskId),
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
