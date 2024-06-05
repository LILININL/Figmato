import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// คลาส PasswordManager สำหรับจัดการฟังก์ชันเกี่ยวกับรหัสผ่าน
class PasswordManager {
  final TextEditingController
      passwordController; // ตัวควบคุม TextField สำหรับรหัสผ่าน
  bool obscureText; // ตัวแปรเพื่อควบคุมการแสดง/ซ่อนรหัสผ่าน

  // Constructor สำหรับกำหนดค่าเริ่มต้นให้กับ passwordController และ obscureText
  PasswordManager(this.passwordController, this.obscureText);

  // ฟังก์ชัน clearPassword ใช้เพื่อเคลียร์ข้อมูลในช่องรหัสผ่าน
  void clearPassword(Function setState) {
    setState(() {
      passwordController.clear(); // เคลียร์ข้อมูลใน TextField ของรหัสผ่าน
    });
  }

  // ฟังก์ชัน togglePasswordVisibility ใช้เพื่อเปลี่ยนสถานะการแสดง/ซ่อนรหัสผ่าน
  void togglePasswordVisibility(Function setState) {
    setState(() {
      obscureText =
          !obscureText; // สลับค่าของ obscureText ระหว่าง true และ false
    });
  }

  // ฟังก์ชัน checkPassword ใช้เพื่อตรวจสอบความถูกต้องของรหัสผ่าน
  void checkPassword(Function setState) {
    // แทนที่เงื่อนไขนี้ด้วยการตรวจสอบพาสเวิร์ดจริง
    if (passwordController.text != 'correct_password') {
      setState(() {
        passwordController
            .clear(); // เคลียร์ข้อมูลใน TextField ของรหัสผ่านหากไม่ถูกต้อง
      });
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