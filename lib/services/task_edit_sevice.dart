import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskEditService {
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  static Future<bool> updateTask(Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.27.143:6004/api/update_todo'),
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update task: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Failed to update task: $e');
      return false;
    }
  }
}
