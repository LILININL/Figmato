import 'package:fristprofigmatest/views/widget/loginfrom/login_page.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/views/widget/homefrom/home_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/login', page: () => const LoginPage()),
  ];
}
