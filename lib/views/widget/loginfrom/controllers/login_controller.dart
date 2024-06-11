import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fristprofigmatest/services/loginapi_service.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var emailErrorText = ''.obs;
  var obscureText = true.obs;

  // สร้าง FocusNode สำหรับแต่ละช่องกรอก
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateEmail);
  }

  @override
  void onClose() {
    // ทำลาย FocusNode เมื่อไม่ใช้แล้ว
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateEmail() {
    emailErrorText.value =
        EmailManager(emailController).validateEmail(emailController.text)
            ? ''
            : 'รูปแบบอีเมลไม่ถูกต้อง';
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void clearPassword() {
    passwordController.clear();
  }

  Future<void> checkPassword() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Log ค่า email และ password
    print('Email: $email');
    print('Password: $password');

    final response = await apiService.checkPassword(email, password);
    if (response != null) {
      await SharedPreferencesHelper.saveUserInfo(
        response.userId,
        response.userEmail,
        response.userFname,
        response.userLname,
      );
      Get.offNamed('/TaskList');
    }
  }
}

// คลาส EmailManager สำหรับจัดการฟังก์ชันเกี่ยวกับอีเมล
class EmailManager {
  final TextEditingController emailController;

  EmailManager(this.emailController);
  // ฟังก์ชัน validateEmail ใช้เพื่อตรวจสอบรูปแบบของอีเมล

  bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }
}

// คลาส EmailInputFormatter สำหรับจัดการการกรองข้อมูลในช่องอีเมล
class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@._-]*$');
    if (emailRegExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
