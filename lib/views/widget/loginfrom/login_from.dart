import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/funtion_manager.dart';

// สร้าง StatefulWidget สำหรับฟอร์มล็อกอิน
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  // ตัวควบคุมสำหรับ TextField ของอีเมลและรหัสผ่าน
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ตัวแปรเพื่อควบคุมการแสดงรหัสผ่าน
  bool obscureText = true;

  // ตัวจัดการรหัสผ่านและอีเมล
  late PasswordManager passwordManager;
  late EmailManager emailManager;

  // ฟังก์ชัน initState() เรียกเมื่อ widget ถูกสร้างครั้งแรก
  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นให้กับ PasswordManager และ EmailManager
    passwordManager = PasswordManager(passwordController, obscureText);
    emailManager = EmailManager(emailController);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // การจัดวางเนื้อหาให้สามารถเลื่อนได้
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
              width: 0,
            ),
            // TextField สำหรับอีเมล
            TextField(
              controller: emailController,
              inputFormatters: [
                EmailInputFormatter()
              ], // กรองข้อมูลให้อยู่ในรูปแบบอีเมล
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 243, 243),
                hintText: 'Email',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(102, 26, 26, 26)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                errorText: emailManager.validateEmail(emailController.text)
                    ? null
                    : null, // ตรวจสอบรูปแบบอีเมล
              ),
            ),
            const SizedBox(
              height: 20.0,
              width: 0,
            ),
            // TextField สำหรับรหัสผ่าน
            TextField(
              controller: passwordController,
              obscureText: passwordManager.obscureText, // ซ่อนรหัสผ่าน
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 243, 243),
                hintText: 'Password',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(102, 26, 26, 26)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ปุ่มแสดง/ซ่อนรหัสผ่าน
                    IconButton(
                      icon: Icon(
                        passwordManager.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      // เมื่อกดปุ่มจะเรียกใช้ฟังก์ชัน togglePasswordVisibility เพื่อเปลี่ยนสถานะการแสดงรหัสผ่าน
                      onPressed: () =>
                          passwordManager.togglePasswordVisibility(setState),
                    ),
                    // ปุ่มลบรหัสผ่าน
                    IconButton(
                      icon: const Icon(Icons.clear),
                      // เมื่อกดปุ่มจะเรียกใช้ฟังก์ชัน clearPassword เพื่อเคลียร์ข้อมูลในช่องรหัสผ่าน
                      onPressed: () => passwordManager.clearPassword(setState),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0, width: 0),
            // ลิงก์สำหรับลืมรหัสผ่าน
            GestureDetector(
              onTap: () {
                // เมื่อแตะที่ลิงก์จะพิมพ์อีเมลและรหัสผ่านปัจจุบันใน console
                Future.delayed(Duration.zero, () {
                  print('Email: ${emailController.text}');
                  print('Password: ${passwordController.text}');
                });
              },
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: forgotPasswordStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
              width: 0,
            ),
            // ปุ่มเข้าสู่ระบบ
            ElevatedButton(
              // เมื่อกดปุ่มจะเรียกใช้ฟังก์ชัน checkPassword ใน PasswordManager
              onPressed: () => passwordManager.checkPassword(setState),
              style: SIGNINButton.buildStyle(),
              child: SIGNINButton.buildChild('SIGN IN'),
            ),
            const SizedBox(
              height: 10.0,
              width: 0,
            ),
            // ปุ่มสมัครสมาชิก
            ElevatedButton(
              onPressed: () {},
              style: SIGNUPButton.buildStyle(),
              child: SIGNUPButton.buildChild('SIGN UP'),
            ),
          ],
        ),
      ),
    );
  }
}

