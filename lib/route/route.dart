import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/login_page.dart';
import 'package:fristprofigmatest/views/widget/signupfrom/signup_page.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/task_list_page.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_add.dart';
import 'package:fristprofigmatest/views/widget/taskfrom/widget/task_edit_page.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/views/widget/homefrom/home_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/Signup',
      page: () => const SignupPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskList',
      page: () => TaskListPage(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskAdd',
      page: () => const TaskAddPage(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/TaskEdit',
      page: () {
        final taskId = Get.parameters['taskId'];
        final title = Get.parameters['title'];
        final desc = Get.parameters['desc'];
        if (taskId == null) {
          return const Center(child: Text('Task ID is missing.'));
        }
        return TaskEditPage(
          taskId: int.parse(taskId),
          initialTitle: title ?? '',
          initialDesc: desc ?? '',
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
//TaskListPage
// Transition.fade: หน้าจอจะค่อยๆ เลือนหายไป (Fade out) แล้วหน้าจอใหม่จะค่อยๆ ปรากฏขึ้น (Fade in)

// Transition.rightToLeft: หน้าจอใหม่จะเลื่อนเข้ามาจากทางขวา และหน้าจอเดิมจะเลื่อนไปทางซ้าย

// Transition.leftToRight: หน้าจอใหม่จะเลื่อนเข้ามาจากทางซ้าย และหน้าจอเดิมจะเลื่อนไปทางขวา

// Transition.upToDown: หน้าจอใหม่จะเลื่อนเข้ามาจากด้านบน และหน้าจอเดิมจะเลื่อนไปด้านล่าง

// Transition.downToUp: หน้าจอใหม่จะเลื่อนเข้ามาจากด้านล่าง และหน้าจอเดิมจะเลื่อนไปด้านบน

// Transition.scale: หน้าจอใหม่จะปรากฏขึ้นด้วยเอฟเฟกต์การขยาย (Scale) จากจุดศูนย์กลาง

// Transition.rotate: หน้าจอใหม่จะปรากฏขึ้นด้วยการหมุน (Rotate) จากมุมหนึ่งไปยังอีกมุมหนึ่ง

// Transition.size: หน้าจอใหม่จะปรากฏขึ้นด้วยการขยายขนาด (Size) จากศูนย์กลางไปเต็มหน้าจอ

// Transition.zoom: หน้าจอใหม่จะปรากฏขึ้นด้วยการขยาย (Zoom) จากจุดศูนย์กลาง

// Transition.topLevel: หน้าจอใหม่จะถูกแสดงขึ้นมาในลำดับชั้นสูงสุด (Top level) ของแอป

// Transition.noTransition: ไม่มีเอฟเฟกต์การเปลี่ยนหน้า (Transition) หน้าจอใหม่จะปรากฏขึ้นทันที

// Transition.cupertino: ใช้สไตล์การเปลี่ยนหน้าของ iOS (Cupertino)

// Transition.native: ใช้สไตล์การเปลี่ยนหน้าของระบบปฏิบัติการที่กำลังใช้งานอยู่ (Native)

// Transition.cupertinoDialog: ใช้สไตล์การเปลี่ยนหน้าของ dialog แบบ Cupertino

// Transition.nativeDialog: ใช้สไตล์การเปลี่ยนหน้าของ dialog แบบ Native