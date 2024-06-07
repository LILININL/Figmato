import 'dart:convert';
import 'package:fristprofigmatest/colors/colors.dart';
import 'package:fristprofigmatest/utils/json/login_jsondata.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.27.143:6004/api';
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  Future<LoginResponse?> checkPassword(String email, String password) async {
    const String apiUrl = '$_baseUrl/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: _headers,
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

