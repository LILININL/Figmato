import 'dart:convert';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:fristprofigmatest/utils/json/task_jsondata.dart';

class TaskService {
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  static Future<List<TaskData>> fetchTodoList() async {
    try {
      final userInfo = await SharedPreferencesHelper.getUserInfo();
      final int userId = userInfo['userid'];

      // เช็คค่า userId
      print('User ID: $userId');

      final response = await http.get(
        Uri.parse('http://192.168.27.143:6004/api/todo_list/$userId'),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        return data.map((json) => TaskData.fromJson(json)).toList();
      } else {
        print('Failed to load todo list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Failed to load todo list: $e');
      return [];
    }
  }
}
