import 'package:flutter/material.dart';
import 'package:fristprofigmatest/utils/json/task_edit_arguments_json.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/bg.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/controller/task_edit_controller.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';

class TaskEditPage extends StatefulWidget {
  final TaskEditPageArguments args;

  const TaskEditPage({
    super.key,
    required this.args,
  });

  @override
  TaskEditPageState createState() => TaskEditPageState();
}

class TaskEditPageState extends State<TaskEditPage> {
  final TaskEditController taskEditController = Get.put(TaskEditController());
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final FocusNode titleFocusNode = FocusNode(); // สร้าง FocusNode สำหรับ title
  final FocusNode descFocusNode =
      FocusNode(); // สร้าง FocusNode สำหรับ description
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.args.initialTitle);
    descriptionController =
        TextEditingController(text: widget.args.initialDesc);
    taskEditController
        .setCompleted(widget.args.initialCompleted); // Set initial value
    _loadUserId(); // โหลด userId
  }

  @override
  void dispose() {
    titleFocusNode.dispose(); // ทำลาย FocusNode เมื่อไม่ใช้งานแล้ว
    descFocusNode.dispose(); // ทำลาย FocusNode เมื่อไม่ใช้งานแล้ว
    super.dispose();
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

  bool _validateInput(String input) {
    return input.trim().isNotEmpty;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
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
            Get.offAllNamed('/TaskList');
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
                            onChanged: (value) {
                              taskEditController.setTitle(value);
                            },
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
                            controller: descriptionController,
                            focusNode: descFocusNode, // ตั้งค่า FocusNode
                            maxLines: 4,
                            textInputAction: TextInputAction
                                .done, // ตั้งค่าให้แสดงปุ่ม "Done"
                            onChanged: (value) {
                              taskEditController.setDescription(value);
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .unfocus(); // ปิดคีย์บอร์ดเมื่อกดปุ่ม "Done"
                            },
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
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
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
                                  Transform.scale(
                                    scale: 0.75, // ปรับขนาด switch โดยใช้ scale
                                    child: SwitchTheme(
                                      data: SwitchThemeData(
                                        thumbColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colors
                                                  .white; // สี thumb ตอนเปิด
                                            }
                                            return Colors
                                                .white; // สี thumb ตอนปิด
                                          },
                                        ),
                                        trackColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colors
                                                  .green; // สี track ตอนเปิด
                                            }
                                            return Colors
                                                .grey.shade400; // สี track ตอนปิด
                                          },
                                        ),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors
                                                .transparent), // สีของ overlay
                                        trackOutlineColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colors
                                                  .transparent; // สีกรอบตอนเปิด
                                            }
                                            return Colors
                                                .transparent; // สีกรอบตอนปิด
                                          },
                                        ),
                                      ),
                                      child: Switch(
                                        value: taskEditController
                                            .taskCompleted.value,
                                        onChanged: (value) {
                                          taskEditController
                                              .setCompleted(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (_validateInput(titleController.text) &&
                        _validateInput(descriptionController.text)) {
                      taskEditController.saveTask(
                        widget.args.taskId,
                        titleController.text.trim(),
                        descriptionController.text.trim(),
                      );
                    } else {
                      _showErrorMessage('Please fill in all fields.');
                    }
                  }
                },
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
