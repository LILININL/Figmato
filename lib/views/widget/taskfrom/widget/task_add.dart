import 'package:flutter/material.dart';
import 'package:fristprofigmatest/utils/json/task_add_jsondata.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';
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
  final _formKey = GlobalKey<FormState>();

  // สร้าง FocusNode สำหรับแต่ละช่องกรอก
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();

  @override
  void dispose() {
    // ทำลาย FocusNode เมื่อไม่ใช้แล้ว
    titleFocusNode.dispose();
    descFocusNode.dispose();
    super.dispose();
  }

  void saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ดึงข้อมูลผู้ใช้จาก SharedPreferences
    final userInfo = await SharedPreferencesHelper.getUserInfo();

    final newTask = TaskAddJsonData(
      userTodoTypeId: 13, // ตัวอย่างการกำหนดค่า
      userTodoListTitle: titleController.text.trim(),
      userTodoListDesc: descController.text.trim(),
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

  bool _validateInput(String input) {
    return input.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Add Your Todo',
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // ปิดคีย์บอร์ดเมื่อกดที่หน้าจอ
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: titleController,
                            focusNode: titleFocusNode, // ตั้งค่า FocusNode
                            textInputAction: TextInputAction
                                .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                  descFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                            },
                            decoration: const InputDecoration(
                              hintText: 'Meeting',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (!_validateInput(value ?? '')) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: descController,
                            focusNode: descFocusNode, // ตั้งค่า FocusNode
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText:
                                  'An effective meeting agenda is a plan you share with your meeting participants. It’ll help your team set clear expectations of what needs to happen before.',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (!_validateInput(value ?? '')) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Text('Success',
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.26,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                              const Spacer(),
                              Transform.scale(
                                scale:
                                    0.75, // ปรับขนาด switch โดยใช้ scale (ค่าเริ่มต้นเป็น 1.0)
                                child: SwitchTheme(
                                  data: SwitchThemeData(
                                    thumbColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .transparent; // สี thumb ตอนเปิด
                                        }
                                        return Colors
                                            .transparent; // สี thumb ตอนปิด
                                      },
                                    ),
                                    trackColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .green; // สี track ตอนเปิด
                                        }
                                        return Colors.grey.shade400; // สี track ตอนปิด
                                      },
                                    ),
                                    overlayColor: MaterialStateProperty.all(Colors
                                        .transparent), // สีของ overlay (จะช่วยให้ดูบางขึ้น)
                                    trackOutlineColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .transparent; // สีกรอบตอนเปิด
                                        }
                                        return Colors
                                            .transparent; // สีกรอบตอนปิด
                                      },
                                    ),
                                  ),
                                  child: Switch(
                                    value: isSuccess,
                                    onChanged: (value) {
                                      setState(() {
                                        isSuccess = value;
                                      });
                                      print('Success status: $isSuccess');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: saveTask,
                style: SIGNINButton.buildStyle(),
                child: SIGNINButton.buildChild('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
