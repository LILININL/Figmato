import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/utils/exitfuntion/loginexit_confirmation_dialog.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/controllers/login_controller.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/login_background.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => loginshowExitConfirmationDialog(context),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // ปิดคีย์บอร์ดเมื่อกดที่หน้าจอ
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/loginbg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(159, 59, 159, 19),
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(90, 0, 99, 15),
                            child: Text(
                              'Please enter the information \n below to access.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(8, 20, 8, 34),
                            child: Image(
                              image: Svg('assets/images/iconsvgs/civic.svg'),
                              height: 98,
                              width: 98,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: <Widget>[
                                Obx(() => TextField(
                                      controller:
                                          loginController.emailController,
                                      focusNode: loginController
                                          .emailFocusNode, // ตั้งค่า FocusNode
                                      textInputAction: TextInputAction
                                          .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                                      onSubmitted: (_) {
                                        FocusScope.of(context).requestFocus(
                                            loginController
                                                .passwordFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                                      },
                                      inputFormatters: [EmailInputFormatter()],
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: bottomColor.b,
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                        errorText: loginController
                                                .emailErrorText.value.isEmpty
                                            ? null
                                            : loginController
                                                .emailErrorText.value,
                                      ),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: Obx(() => TextField(
                                        controller:
                                            loginController.passwordController,
                                        focusNode: loginController
                                            .passwordFocusNode, // ตั้งค่า FocusNode
                                        textInputAction: TextInputAction
                                            .done, // ตั้งค่าให้แสดงปุ่ม "Done"
                                        onSubmitted: (_) {
                                          loginController
                                              .checkPassword(); // เรียกฟังก์ชัน checkPassword เมื่อผู้ใช้กดปุ่ม "Done"
                                        },
                                        obscureText:
                                            loginController.obscureText.value,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: bottomColor.b,
                                          hintText: 'Password',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  loginController
                                                          .obscureText.value
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: loginController
                                                    .togglePasswordVisibility,
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.clear),
                                                onPressed: loginController
                                                    .clearPassword,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 19.0, right: 6),
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Forgot Password? bottom');
                                    },
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Forgot Password?',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => loginController.checkPassword(),
                        style: SIGNINButton.buildStyle(),
                        child: SIGNINButton.buildChild('SIGN IN'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offNamed('/Signup');
                          },
                          style: SIGNUPButton.buildStyle(),
                          child: SIGNUPButton.buildChild('SIGN UP'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
