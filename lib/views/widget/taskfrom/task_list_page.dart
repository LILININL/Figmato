import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/utils/exitfuntion/exit_confirmation_dialog.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/profile_bottom_sheet.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit_morevert.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_card_item.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart'; // import สำหรับตรวจสอบการเชื่อมต่ออินเทอร์เน็ต
import 'widget/controller/task_controller.dart';

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
      checkInternetConnection();
    });
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

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isInternetConnected = connectivityResult != ConnectivityResult.none;
    });

    if (!isInternetConnected) {
      // แสดงข้อความแจ้งเตือนเมื่อไม่มีการเชื่อมต่ออินเทอร์เน็ต
      Get.snackbar(
        'ไม่พบอินเตอร์เน็ต',
        'กรุณาตรวจสอบการเชื่อมต่ออินเตอร์เน็ตของคุณ',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> refreshData() async {
    await taskController.fetchTodoList();
    setState(() {}); // Refresh the state of the widget
    checkInternetConnection();
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
          child: FutureBuilder(
            future: taskController.fetchTodoList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                checkInternetConnection(); // ตรวจสอบการเชื่อมต่ออินเทอร์เน็ตเมื่อเกิดข้อผิดพลาด
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Column(
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
                    const SizedBox(
                        height: 8), // เพิ่ม spacing ระหว่างปุ่มและรายการ
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
                              children:
                                  taskController.filteredTodoList.map((todo) {
                                return TaskItem(
                                  id: todo.userTodoListId, // ตรวจสอบค่า null
                                  title:
                                      todo.userTodoListTitle, // ตรวจสอบค่า null
                                  time: todo.userTodoListLastUpdate
                                      .toString(), // ตรวจสอบค่า null
                                  description:
                                      todo.userTodoListDesc, // ตรวจสอบค่า null
                                  isCompleted:
                                      todo.userTodoListCompleted == "true",
                                  onChanged: (value) {
                                    taskController.toggleCompletion(
                                        todo.userTodoListId, value!);
                                    print(
                                        'เช็ค todo  ID: ${todo.userTodoListId}');
                                  },
                                  onEdit: () async {
                                    final result =
                                        await showTaskEditBottomSheet(
                                      context,
                                      todo.userTodoListId,
                                      todo.userTodoListTitle, // ตรวจสอบค่า null
                                      todo.userTodoListDesc, // ตรวจสอบค่า null
                                      todo.userTodoListCompleted ==
                                          "true", // ส่งค่า completed
                                    );
                                    if (result == true) {
                                      await taskController
                                          .fetchTodoList(); // รีโหลดข้อมูลเมื่อกลับมาจากหน้าแก้ไข
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
                );
              }
            },
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
