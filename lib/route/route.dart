import 'package:fristprofigmatest/views/login_page.dart';
import 'package:fristprofigmatest/views/signup_page.dart';
import 'package:fristprofigmatest/views/task_list_page.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/views/home_page.dart';

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
  ];
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