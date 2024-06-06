import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/taskfrom/widget/profile_bottom_sheet.dart';
import 'package:fristprofigmatest/views/taskfrom/widget/task_edit.dart';
import 'package:fristprofigmatest/views/taskfrom/widget/task_item.dart';
import 'package:get/get.dart';
import 'taskfrom/widget/controller/task_controller.dart';

class TaskListPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // เอาปุ่ม back ออก
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        flexibleSpace: Container(
          decoration: MyAppGradients.imageBackground(
              'assets/images/taskappbbarbg.png'), // ใช้พื้นหลังเป็นรูปภาพ
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showProfileBottomSheet(
                      context); // เรียกใช้ฟังก์ชันจากไฟล์ profile_bottom_sheet.dart
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'N', // ใช้อักษรย่อของผู้ใช้แบบชั่วคราว
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 16,height: 0,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Adjust size as needed
                    ),
                  ),
                  Text(
                    'Natalie Keily', // ใช้ชื่อผู้ใช้แบบชั่วคราว
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24, // Adjust size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                taskController.updateSearchText(value);
              },
              decoration: InputDecoration(
                hintText: "Search.......",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    taskController.selectAll(true);
                    final selectedTodos = taskController.todoList
                        .where((todo) => todo.userTodoListCompleted == 'true')
                        .toList();
                    for (var todo in selectedTodos) {
                      print('Selected todo with ID: ${todo.userTodoListId}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("เลือกทั้งหมด",style: TextStyle(color: Colors.black87),),
                ),
                const SizedBox(width: 8 ,height: 0,),
                ElevatedButton(
                  onPressed: () {
                    taskController.selectAll(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("ยกเลิกการเลือกทั้งหมด",style: TextStyle(color: Colors.black87),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8,width: 0,), // เพิ่ม spacing ระหว่างปุ่มและรายการ
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                taskController.fetchTodoList();
              },
              child: Obx(() {
                if (taskController.todoList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
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
                          taskController.toggleCompletion(
                              todo.userTodoListId, value!);
                        },
                        onEdit: () {
                          showTaskEditBottomSheet(
                              context); // เรียกใช้ฟังก์ชันจากไฟล์ task_edit.dart
                        },
                      );
                    }).toList(),
                  );
                }
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new task action
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }
}
