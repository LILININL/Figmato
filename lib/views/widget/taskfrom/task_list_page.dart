import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/utils/exitfuntion/exit_confirmation_dialog.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/profile_bottom_sheet.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_item.dart';
import 'package:get/get.dart';
import 'widget/controller/task_controller.dart';

class TaskListPage extends StatefulWidget {
  @override
  TaskListPageState createState() => TaskListPageState();
}

String getShortenedUserName(String fname, String lname, int maxLength) {
  String fullName = '$fname $lname';
  if (fullName.length > maxLength) {
    return fullName.substring(0, maxLength) + '...........';
  }
  return fullName;
}

class TaskListPageState extends State<TaskListPage> {
  final TaskController taskController = Get.put(TaskController());
  String fullName = '';
  String initial = '';
  final int maxLength = 10; // กำหนดความยาวสูงสุดของชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userInfo = await SharedPreferencesHelper.getUserInfo();
    setState(() {
      if (userInfo[SharedPreferencesHelper.Fname] != null &&
          userInfo[SharedPreferencesHelper.Lname] != null) {
        fullName = getShortenedUserName(
          userInfo[SharedPreferencesHelper.Fname]!,
          userInfo[SharedPreferencesHelper.Lname]!,
          maxLength,
        );
        initial = userInfo[SharedPreferencesHelper.Fname]!
            .substring(0, 1)
            .toUpperCase();
      } else {
        fullName = 'Guest';
        initial = 'G';
      }
    });
    print('Loaded user name: $fullName'); // Add this line to debug
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitConfirmationDialog(context),
      child: Scaffold(
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
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      initial, // ใช้อักษรย่อของผู้ใช้
                      style: const TextStyle(color: NotificationColors.dark),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'สวัสดี !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      fullName, // ใช้ชื่อผู้ใช้จาก SharedPreferences
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Adjust size as needed
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
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  taskController.updateSearchText(value);
                },
                decoration: InputDecoration(
                  hintText: "ค้นหา.......",
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
                    child: const Text("เลือกทั้งหมด",
                        style: TextStyle(color: Colors.black87)),
                  ),
                  const SizedBox(width: 8),
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
                    child: const Text("ยกเลิกการเลือกทั้งหมด",
                        style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // เพิ่ม spacing ระหว่างปุ่มและรายการ
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
                            print(
                                'Selected todo with ID: ${todo.userTodoListId}');
                          },
                          onEdit: () {
                            showTaskEditBottomSheet(
                                context, todo.userTodoListId); // ส่ง taskId
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
            print('object');
            // Add new task action
          },
          child: Image.asset('assets/icons/ButtonAdd.png'),
        ),
      ),
    );
  }
}


// final int maxLength = 10; // กำหนดความยาวสูงสุดของชื่อผู้ใช้
  // String fullName = '';
  // final int lastNameMaxLength = 10; // กำหนดความยาวสูงสุดของนามสกุล

// String getShortenedUserName(String userName, int maxLength) {
//   if (userName.length > maxLength) {
//     return userName.substring(0, maxLength) + '...';
//   }
//   return userName;
// }
// String getShortenedLastName(String lastName, int maxLength) {
//   if (lastName.length > maxLength) {
//     return lastName.substring(0, maxLength) + '...';
//   }
//   return lastName;
// }

 // userName = userInfo[SharedPreferencesHelper.Fname] != null
      //     ? getShortenedUserName(
      //         '${userInfo[SharedPreferencesHelper.Fname]} ${userInfo[SharedPreferencesHelper.Lname]}',
      //         maxLength)
      //     : 'Guest';
      // final firstName = userInfo[SharedPreferencesHelper.Fname] ?? 'Guest';
      // final lastName = userInfo[SharedPreferencesHelper.Lname] != null
      //     ? getShortenedLastName(
      //         userInfo[SharedPreferencesHelper.Lname]!, lastNameMaxLength)
      //     : '';
      // fullName = '$firstName $lastName';
