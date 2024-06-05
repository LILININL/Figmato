import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/funtion_manager.dart';


class LoginForm extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
              width: 0,
            ),
            TextField(
              controller: loginController.emailController,
              inputFormatters: [EmailInputFormatter()],
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
                  errorText: EmailManager(loginController.emailController)
                          .validateEmail(loginController.emailController.text)
                      ? null
                      : 'รุปแปปอีเมลไม่ถูกต้อง'),
            ),
            const SizedBox(
              height: 20.0,
              width: 0,
            ),
            Obx(() => TextField(
                  controller: loginController.passwordController,
                  obscureText: loginController.obscureText.value,
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            loginController.obscureText.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: loginController.togglePasswordVisibility,
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: loginController.clearPassword,
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 10.0, width: 0),
            GestureDetector(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  print('Email: ${loginController.emailController.text}');
                  print('Password: ${loginController.passwordController.text}');
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
            ElevatedButton(
              onPressed: () => loginController
                  .checkPassword(loginController.emailController.text),
              style: SIGNINButton.buildStyle(),
              child: SIGNINButton.buildChild('SIGN IN'),
            ),
            const SizedBox(
              height: 10.0,
              width: 0,
            ),
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
