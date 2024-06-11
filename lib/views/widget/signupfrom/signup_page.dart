import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/utils/exitfuntion/loginexit_confirmation_dialog.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/button_styles.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/login_background.dart';
import 'package:fristprofigmatest/views/widget/signupfrom/controller/signup_controller.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/login_page.dart';

class SignupPage extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => loginshowExitConfirmationDialog(context),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // ปิดคีย์บอร์ดเมื่อกดที่หน้าจอ
          },
          child: Stack(
            children: <Widget>[
              const loginBackgroundWidget(),
              Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'Please enter the information \n below to access.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 20, 8, 60),
                              child: Image(
                                image: Svg('assets/images/iconsvgs/civic.svg'),
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Column(
                                children: <Widget>[
                                  Obx(() => TextField(
                                        controller: signupController
                                            .firstNameController,
                                        focusNode: signupController
                                            .firstNameFocusNode, // ตั้งค่า FocusNode
                                        textInputAction: TextInputAction
                                            .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              signupController
                                                  .lastNameFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          hintText: 'First name',
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  102, 26, 26, 26)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                          errorText: signupController
                                                  .firstNameErrorText
                                                  .value
                                                  .isEmpty
                                              ? null
                                              : signupController
                                                  .firstNameErrorText.value,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 35.0,
                                    width: 0,
                                  ),
                                  Obx(() => TextField(
                                        controller:
                                            signupController.lastNameController,
                                        focusNode: signupController
                                            .lastNameFocusNode, // ตั้งค่า FocusNode
                                        textInputAction: TextInputAction
                                            .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              signupController
                                                  .emailFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          hintText: 'Last name',
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  102, 26, 26, 26)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                          errorText: signupController
                                                  .lastNameErrorText
                                                  .value
                                                  .isEmpty
                                              ? null
                                              : signupController
                                                  .lastNameErrorText.value,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 35.0,
                                    width: 0,
                                  ),
                                  Obx(() => TextField(
                                        controller:
                                            signupController.emailController,
                                        focusNode: signupController
                                            .emailFocusNode, // ตั้งค่า FocusNode
                                        textInputAction: TextInputAction
                                            .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              signupController
                                                  .passwordFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                                        },
                                        inputFormatters: [
                                          EmailInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  102, 26, 26, 26)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                          errorText: signupController
                                                  .emailErrorText.value.isEmpty
                                              ? null
                                              : signupController
                                                  .emailErrorText.value,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 35.0,
                                    width: 0,
                                  ),
                                  Obx(() => TextField(
                                        controller:
                                            signupController.passwordController,
                                        focusNode: signupController
                                            .passwordFocusNode, // ตั้งค่า FocusNode
                                        textInputAction: TextInputAction
                                            .done, // ตั้งค่าให้แสดงปุ่ม "Done"
                                        onSubmitted: (_) {
                                          signupController
                                              .register(); // เรียกฟังก์ชัน register เมื่อผู้ใช้กดปุ่ม "Done"
                                        },
                                        obscureText:
                                            signupController.obscureText.value,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  102, 26, 26, 26)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  signupController
                                                          .obscureText.value
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: signupController
                                                    .togglePasswordVisibility,
                                              ),
                                            ],
                                          ),
                                          errorText: signupController
                                                  .passwordErrorText
                                                  .value
                                                  .isEmpty
                                              ? null
                                              : signupController
                                                  .passwordErrorText.value,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: signupController.register,
                          style: SIGNUPButton.buildStyle(),
                          child: SIGNUPButton.buildChild('SIGN UP'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.offAll(() => LoginPage(),
                        transition: Transition.rightToLeft);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
