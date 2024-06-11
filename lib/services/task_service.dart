// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:fristprofigmatest/utils/json/task_jsondata.dart';

class TaskService {
  static Future<List<TaskData>> fetchTodoList() async {
    try {
      final userInfo = await SharedPreferencesHelper.getUserInfo();
      final int userId = userInfo['userid'] ?? 0;

      // เช็คค่า userId
      print('User ID: $userId');

      final response = await http
          .get(
            Uri.parse('$baseUrl/todo_list/$userId'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2)); // กำหนด timeout 2 นาที
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;

        // กรองข้อมูลที่มีค่า null
        List<TaskData> filteredData =
            data.map((json) => TaskData.fromJson(json)).where((task) {
          return task.userTodoListId != null &&
              task.userTodoListTitle != null &&
              task.userTodoListLastUpdate != null &&
              task.userTodoListDesc != null &&
              task.userTodoListCompleted != null;
        }).toList();

        return filteredData;
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
