import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void clearPassword() {
    passwordController.clear();
  }

  Future<void> checkPassword(String email) async {
    // Log ค่า email และ password
    print('Email: $email');
    print('Password: ${passwordController.text}');
    const String apiUrl = 'http://172.20.10.7:6004/api/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'user_email': email,
        'user_password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responseBody);
        Get.offNamed('/home');
      }
    } else {
      print(response.statusCode);
      passwordController.clear();
      Get.snackbar('Error', 'อีเมลหรือหรัสผ่านไม่ถูกต้อง');
    }
  }
}

// คลาส EmailManager สำหรับจัดการฟังก์ชันเกี่ยวกับอีเมล
class EmailManager {
  final TextEditingController
      emailController; // ตัวควบคุม TextField สำหรับอีเมล

  // Constructor สำหรับกำหนดค่าเริ่มต้นให้กับ emailController
  EmailManager(this.emailController);

  // ฟังก์ชัน validateEmail ใช้เพื่อตรวจสอบรูปแบบของอีเมล
  bool validateEmail(String email) {
    // Regular expression สำหรับตรวจสอบรูปแบบอีเมล
    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email); // คืนค่าผลการตรวจสอบรูปแบบอีเมล
  }
}

// คลาส EmailInputFormatter สำหรับจัดการการกรองข้อมูลในช่องอีเมล
class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression สำหรับกรองข้อมูลให้อยู่ในรูปแบบอีเมล
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9@._-]*$');
    if (emailRegExp.hasMatch(newValue.text)) {
      return newValue; // คืนค่าข้อความใหม่ถ้าอยู่ในรูปแบบอีเมล
    }
    return oldValue; // คืนค่าข้อความเก่าถ้าไม่อยู่ในรูปแบบอีเมล
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
