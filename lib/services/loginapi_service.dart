import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.27.143:6004/api';
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  Future<void> checkPassword(String email, String password) async {
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
        print(responseBody);
        Get.offNamed('/TaskList');
      } else {
        print(response.statusCode);
        Get.snackbar('ผิดพลาด', 'อีเมลหรือรหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      print('ผิดพลาด: $e');
      Get.snackbar('ผิดพลาด', 'เกิดข้อผิดพลาดบางอย่าง');
    }
  }
}