import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fristprofigmatest/colors/colors.dart';
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
                              padding: EdgeInsets.fromLTRB(159, 59, 159, 19),
                              child: Text(
                                'SIGN UP',
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
                                  const EdgeInsets.fromLTRB(20, 20, 29, 20),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 9),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 59, // กำหนดความสูงของปุ่ม
                                      child: TextField(
                                        controller: signupController
                                            .firstNameController,
                                        focusNode:
                                            signupController.firstNameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              signupController
                                                  .lastNameFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: bottomColor.b,
                                          hintText: 'First name',
                                          hintStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 19.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 9),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 59, // กำหนดความสูงของปุ่ม
                                      child: TextField(
                                        controller:
                                            signupController.lastNameController,
                                        focusNode:
                                            signupController.lastNameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              signupController.emailFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: bottomColor.b,
                                          hintText: 'Last name',
                                          hintStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 19.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 69, // กำหนดความสูงของปุ่ม
                                          child: TextField(
                                            controller: signupController
                                                .emailController,
                                            focusNode: signupController
                                                .emailFocusNode, // ตั้งค่า FocusNode
                                            textInputAction: TextInputAction
                                                .next, // ตั้งค่าให้แสดงปุ่ม "Next"
                                            onSubmitted: (_) {
                                              FocusScope.of(context)
                                                  .requestFocus(signupController
                                                      .passwordFocusNode); // ย้ายโฟกัสไปยังช่องถัดไป
                                            },
                                            inputFormatters: [
                                              EmailInputFormatter()
                                            ],
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
                                                      horizontal: 19.0),
                                              errorText: signupController
                                                      .emailErrorText
                                                      .value
                                                      .isEmpty
                                                  ? null
                                                  : signupController
                                                      .emailErrorText.value,
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 59, // กำหนดความสูงของปุ่ม
                                    child: TextField(
                                      controller:
                                          signupController.passwordController,
                                      focusNode:
                                          signupController.passwordFocusNode,
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (_) {
                                        signupController.register();
                                      },
                                      obscureText:
                                          signupController.obscureText.value,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: bottomColor.b,
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 19.0),
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
                  icon: Image.asset('assets/icons/Arrowleft.png'),
                  hoverColor: Colors.transparent,
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
