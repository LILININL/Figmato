import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/controller/task_edit_controller.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';

class TaskEditPage extends StatefulWidget {
  final int taskId;
  final String initialTitle;
  final String initialDesc;
  final bool initialCompleted;

  const TaskEditPage({
    super.key,
    required this.taskId,
    required this.initialTitle,
    required this.initialDesc,
    required this.initialCompleted,
  });

  @override
  TaskEditPageState createState() => TaskEditPageState();
}

class TaskEditPageState extends State<TaskEditPage> {
  final TaskEditController taskEditController = Get.put(TaskEditController());
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController = TextEditingController(text: widget.initialDesc);
    taskEditController
        .setCompleted(widget.initialCompleted); // Set initial value
    _loadUserId(); // โหลด userId
    taskEditController.setUserTodoTypeId(13); // ค่าเริ่มต้น
    taskEditController.setUserTodoTypeName("Objective-C"); // ค่าเริ่มต้น
  }

  Future<void> _loadUserId() async {
    final userInfo = await SharedPreferencesHelper.getUserInfo();
    final userId = userInfo[SharedPreferencesHelper.UserId];
    if (userId != null) {
      taskEditController.setUserId(userId.toString());
    } else {
      taskEditController.setUserId('0'); // ค่าเริ่มต้นหากไม่มี userId
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'You Todu',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          isSelected: false,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Image.asset(
            'assets/icons/Arrowleft.png',
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        flexibleSpace: Container(
          decoration:
              MyAppGradients.imageBackground('assets/images/taskappbbarbg.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  taskEditController.setTitle(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Meeting',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  taskEditController.setDescription(value);
                },
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      'An effective meeting agenda is a plan you share with your meeting participants. It’ll help your team set clear expectations of what needs to happen before.',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text('Success',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      const Spacer(),
                      Switch(
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green, // สี track ตอนเปิด
                        inactiveThumbColor: Colors.white, // สี thumb ตอนปิด
                        inactiveTrackColor: Colors.grey, // สี track ตอนปิด
                        value: taskEditController.taskCompleted.value,
                        onChanged: (value) {
                          taskEditController.setCompleted(value);
                        },
                      ),
                    ],
                  ),
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                taskEditController.saveTask(
                  widget.taskId,
                  widget.initialTitle,
                  widget.initialDesc,
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ), // Background color
              ),
              child: const Text('Save',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
