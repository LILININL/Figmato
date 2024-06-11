import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
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
        body: Stack(
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
                              'SIGN IN',
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
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: <Widget>[
                                Obx(() => TextField(
                                      controller:
                                          loginController.emailController,
                                      inputFormatters: [EmailInputFormatter()],
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            const Color.fromARGB(255, 243, 243, 243),
                                        hintText: 'Email',
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                102, 26, 26, 26)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
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
                                        obscureText:
                                            loginController.obscureText.value,
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
                                          contentPadding: const EdgeInsets.symmetric(
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
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Future.delayed(Duration.zero, () {
                                        print('Forgot Password? bottom');
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
          ],
        ),
      ),
    );
  }
}
