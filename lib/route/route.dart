import 'package:flutter/material.dart';
import 'package:fristprofigmatest/utils/json/task_edit_arguments_json.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/login_page.dart';
import 'package:fristprofigmatest/views/widget/signupfrom/signup_page.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/task_list_page.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_add.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit_page.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/views/widget/homefrom/home_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/Signup',
      page: () => SignupPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskList',
      page: () => TaskListPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskAdd',
      page: () => const TaskAddPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskEdit',
      page: () {
        final taskId = Get.parameters['taskId'];
        final title = Get.parameters['title'];
        final desc = Get.parameters['desc'];
        final completed = Get.parameters['completed'];

        if (taskId == null) {
          return const Center(child: Text('Task ID is missing.'));
        }

        return TaskEditPage(
          args: TaskEditPageArguments(
            taskId: int.parse(taskId),
            initialTitle: title ?? '',
            initialDesc: desc ?? '',
            initialCompleted: completed == 'true',
          ),
        );
      },
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}

String determineInitialRoute(bool isLoggedIn) {
  return isLoggedIn ? '/TaskList' : '/';
}
