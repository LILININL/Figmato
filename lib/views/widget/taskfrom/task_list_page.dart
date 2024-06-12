import 'package:flutter/material.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/utils/exitfuntion/exit_confirmation_dialog.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/profile_bottom_sheet.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_card_item.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit_morevert.dart';
import 'package:get/get.dart';
import 'widget/controller/task_controller.dart';
import 'package:intl/intl.dart'; // นำเข้า intl

class TaskListPage extends StatefulWidget {
  @override
  TaskListPageState createState() => TaskListPageState();
}

class TaskListPageState extends State<TaskListPage> {
  final TaskController taskController = Get.put(TaskController());
  String fullName = '';
  String initial = '';
  bool isInternetConnected = true;
  final int maxLength = 9999; // กำหนดความยาวสูงสุดของชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserName();
    });
    if (Get.arguments == true) {
      refreshData(); // เรียกใช้ฟังก์ชัน refreshData เมื่อได้รับ argument เป็น true
    }
  }

  String formatDateTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('hh:mm a -MM/dd/yy');
    return formatter.format(dateTime);
  }

  Future<void> loadUserName() async {
    final userInfo = await SharedPreferencesHelper.getUserInfo();
    setState(() {
      if (userInfo[SharedPreferencesHelper.Fname] != null &&
          userInfo[SharedPreferencesHelper.Lname] != null) {
        fullName = capitalize(getShortenedUserName(
          userInfo[SharedPreferencesHelper.Fname] ?? '',
          userInfo[SharedPreferencesHelper.Lname] ?? '',
          maxLength,
        ));
        initial = (userInfo[SharedPreferencesHelper.Fname] ?? '')
            .substring(0, 1)
            .toUpperCase();
      } else {
        fullName = 'Guest';
        initial = 'G';
      }
    });
    print('Loaded user name: $fullName'); // Debug
  }

  String capitalize(String text) {
    if (text.isEmpty) {
      return '';
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  String getShortenedUserName(String fname, String lname, int maxLength) {
    String fullName = '$fname $lname';
    if (fullName.length > maxLength) {
      return '${fullName.substring(0, maxLength)}...........';
    }
    return fullName;
  }

  Future<void> refreshData() async {
    await taskController.fetchTodoList();
    setState(() {}); // Refresh the state of the widget
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitConfirmationDialog(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // เอาปุ่ม back ออก
          backgroundColor: Colors.transparent,
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
                Expanded(
                  child: Column(
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
                        capitalize(
                            fullName), // ใช้ชื่อผู้ใช้จาก SharedPreferences
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // ปิดคีย์บอร์ดเมื่อกดที่หน้าจอ
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      taskController.updateSearchText(value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: Colors.transparent,
                      hintText: "ค้นหา.......",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset('assets/images/searchnormal1.png'),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshData,
                  child: Obx(() {
                    if (taskController.filteredTodoList.isEmpty) {
                      return ListView(
                        children: [
                          Center(
                            child: Text(isInternetConnected
                                ? 'ไม่มีข้อมูล'
                                : 'ไม่พบอินเตอร์เน็ต'),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        children: taskController.filteredTodoList.map((todo) {
                          return TaskItem(
                            id: todo.userTodoListId,
                            title: todo.userTodoListTitle,
                            time: formatDateTime(
                                todo.userTodoListLastUpdate.toString()),
                            description: todo.userTodoListDesc,
                            isCompleted: todo.userTodoListCompleted == "true",
                            onChanged: (value) {
                              taskController.toggleCompletion(
                                  todo.userTodoListId, value!);
                              print('เช็ค todo  ID: ${todo.userTodoListId}');
                            },
                            onEdit: () async {
                              final result = await showTaskEditBottomSheet(
                                context,
                                todo.userTodoListId,
                                todo.userTodoListTitle,
                                todo.userTodoListDesc,
                                todo.userTodoListCompleted == "true",
                              );
                              if (result == true) {
                                await taskController.fetchTodoList();
                              }
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
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          focusElevation: 0,
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            print('object');
            Get.toNamed('/TaskAdd');
          },
          child: Image.asset('assets/icons/ButtonAdd.png'),
        ),
      ),
    );
  }
}
