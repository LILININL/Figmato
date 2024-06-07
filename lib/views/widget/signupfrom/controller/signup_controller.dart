import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/login_page.dart';
import 'package:get/get.dart';
import 'package:fristprofigmatest/services/signupapi_service.dart'; // Import the ApiService

class SignupController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var firstNameErrorText = ''.obs;
  var lastNameErrorText = ''.obs;
  var emailErrorText = ''.obs;
  var passwordErrorText = ''.obs;
  var obscureText = true.obs;

  final ApiService apiService =
      Get.put(ApiService()); // Initialize the ApiService

  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void clearPassword() {
    passwordController.clear();
  }

  void register() async {
    if (validateForm()) {
      try {
        final response = await apiService.signup(
          emailController.text,
          passwordController.text,
          firstNameController.text,
          lastNameController.text,
        );
        if (response['status'] == 'success') {
          Get.snackbar('Success', 'สมัครสมาชิคสำเร็จ',
              snackPosition: SnackPosition.TOP, colorText: Colors.black);
          Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
        } else {
          Get.snackbar(
            'ผิดพลาด',
            'อีเมลนี้มีผู้ใช้งานแล้ว..',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.black,
          );
        }
      } catch (e) {
        Get.snackbar(
          'ผิดพลาด',
          'ติดต่อผู่ดูแลระบบ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.black,
        );
      }
    } else {
      showErrorPopup();
    }
  }

  bool validateForm() {
    bool isValid = true;

    if (firstNameController.text.isEmpty) {
      firstNameErrorText.value = 'กรุณากรอก ชื่อ';
      isValid = false;
    } else {
      firstNameErrorText.value = '';
    }

    if (lastNameController.text.isEmpty) {
      lastNameErrorText.value = 'กรุณากรอก นามสกุล';
      isValid = false;
    } else {
      lastNameErrorText.value = '';
    }

    if (emailController.text.isEmpty) {
      emailErrorText.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailErrorText.value = 'รุปแบบมีเมลไม่ถูกต้อง..';
      isValid = false;
    } else {
      emailErrorText.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordErrorText.value = 'กรุณากรอกรหัสผ่าน';
      isValid = false;
    } else {
      passwordErrorText.value = '';
    }

    return isValid;
  }

  void showErrorPopup() {
    Get.snackbar(
      'ผิดพลาด',
      'กรุณากรอกข้อมูลในช่องให้ครบ',
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
    );
  }
}
