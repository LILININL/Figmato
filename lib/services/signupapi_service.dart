import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxService {
  static const String _baseUrl = 'http://192.168.27.143:6004/api/create_user';
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  Future<Map<String, dynamic>> signup(String email, String password, String firstName, String lastName) async {
    final url = Uri.parse(_baseUrl);
    final body = jsonEncode({
      'user_email': email,
      'user_password': password,
      'user_fname': firstName,
      'user_lname': lastName,
    });

    final response = await http.post(url, headers: _headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body == "OK") {
        return {'status': 'success', 'message': 'Signup successful'};
      } else {
        final responseData = jsonDecode(response.body);
        return {'status': responseData['message'] == 'This e-mail has already been used..' ? 'error' : 'success', 'message': responseData['message']};
      }
    } else {
      final responseData = jsonDecode(response.body);
      return {'status': 'error', 'message': responseData['message']};
    }
  }
}
