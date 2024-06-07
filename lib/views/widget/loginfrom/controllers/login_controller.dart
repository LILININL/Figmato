import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fristprofigmatest/services/loginapi_service.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var emailErrorText = ''.obs;
  var obscureText = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateEmail);
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

// รายละเอียดของแต่ละส่วน
// PasswordManager
// PasswordManager(this.passwordController, this.obscureText);: Constructor สำหรับกำหนดค่าเริ่มต้นให้กับ passwordController และ obscureText
// void clearPassword(Function setState): ฟังก์ชันที่ใช้เคลียร์ข้อความใน TextField ของรหัสผ่าน
// setState: ฟังก์ชันที่ใช้เพื่ออัพเดทสถานะของ widget ใน Flutter
// passwordController.clear(): เคลียร์ข้อความใน TextField ของรหัสผ่าน
// void togglePasswordVisibility(Function setState): ฟังก์ชันที่ใช้เปลี่ยนสถานะการแสดง/ซ่อนรหัสผ่าน
// obscureText = !obscureText: สลับค่าระหว่าง true และ false ของ obscureText เพื่อแสดงหรือซ่อนรหัสผ่าน
// void checkPassword(Function setState): ฟังก์ชันที่ใช้ตรวจสอบความถูกต้องของรหัสผ่าน
// ตรวจสอบว่ารหัสผ่านที่ผู้ใช้กรอกตรงกับรหัสผ่านที่กำหนดไว้ ('correct_password') หรือไม่
// ถ้าไม่ตรง จะเคลียร์ข้อความใน TextField ของรหัสผ่าน
// EmailManager
// EmailManager(this.emailController): Constructor สำหรับกำหนดค่าเริ่มต้นให้กับ emailController
// bool validateEmail(String email): ฟังก์ชันที่ใช้ตรวจสอบรูปแบบของอีเมล
// ใช้ Regular Expression (RegExp) เพื่อตรวจสอบว่าอีเมลที่กรอกถูกต้องหรือไม่
// EmailInputFormatter
// TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue): ฟังก์ชันที่ใช้กรองข้อความในช่อง TextField ของอีเมล
// ใช้ Regular Expression (RegExp) เพื่อตรวจสอบว่าข้อความที่กรอกอยู่ในรูปแบบอีเมลหรือไม่
// ถ้าข้อความใหม่อยู่ในรูปแบบอีเมล จะคืนค่าข้อความใหม่ (newValue)
// ถ้าไม่อยู่ในรูปแบบอีเมล จะคืนค่าข้อความเก่า (oldValue)
