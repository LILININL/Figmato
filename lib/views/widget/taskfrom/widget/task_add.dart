import 'package:flutter/material.dart';
import 'package:fristprofigmatest/utils/json/task_add_jsondata.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:get/get.dart';
import 'controller/task_add_controller.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({super.key});

  @override
  TaskAddPageState createState() => TaskAddPageState();
}

class TaskAddPageState extends State<TaskAddPage> {
  final TaskAddController controller = Get.put(TaskAddController());
  bool isSuccess = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void saveTask() async {
    // ดึงข้อมูลผู้ใช้จาก SharedPreferences
    final userInfo = await SharedPreferencesHelper.getUserInfo();

    final newTask = TaskAddJsonData(
      userTodoTypeId: 13, // ตัวอย่างการกำหนดค่า
      userTodoListTitle: titleController.text,
      userTodoListDesc: descController.text,
      userTodoListCompleted: isSuccess,
      userId: userInfo[SharedPreferencesHelper.UserId] as int,
    );

    bool result = await controller.createTodo(newTask);

    if (result) {
      Get.snackbar(
        'ยินดีด้วย',
        'สร้าง Todo สำเร็จแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/TaskList');
    } else {
      Get.snackbar(
        'ล้มเหลว',
        'ไม่สามารถสร้างได้',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Add You Todo',
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
                controller: descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      'An effective meeting agenda is a plan you share with your meeting participants. It’ll help your team set clear expectations of what needs to happen before.',
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
              child: Row(
                children: [
                  const Text('Success',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                  const Spacer(),
                  Switch(
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green, // สี track ตอนเปิด
                    inactiveThumbColor: Colors.white, // สี thumb ตอนปิด
                    inactiveTrackColor: Colors.grey, // สี track ตอนปิด
                    value: isSuccess,
                    onChanged: (value) {
                      setState(() {
                        isSuccess = value;
                      });
                      print('Success status: $isSuccess');
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: saveTask,
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
