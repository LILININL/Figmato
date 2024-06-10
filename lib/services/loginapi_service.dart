import 'dart:convert';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:fristprofigmatest/utils/json/login_jsondata.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  Future<LoginResponse?> checkPassword(String email, String password) async {
    const String apiUrl = '$baseUrl/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(<String, String>{
          'user_email': email,
          'user_password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return LoginResponse.fromJson(responseBody);
      } else {
        print(response.statusCode);
        Get.snackbar('ผิดพลาด', 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
            colorText: NotificationColors.dark);
        return null;
      }
    } catch (e) {
      print('ผิดพลาด: $e');
      Get.snackbar('ผิดพลาด',
          'เกิดข้อผิดพลาดบางอย่างทำให้ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้ \nโปรดเช็คการเชื่อมต่อของคุณ',
          colorText: NotificationColors.dark);
      return null;
    }
  }
}
