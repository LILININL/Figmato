import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:http/http.dart' as http;

class DeleteTaskService {
  static Future<void> deleteTask(int taskId) async {
    final url = Uri.parse('$baseUrl/delete_todo/${taskId.toString()}');
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      print('Task deleted successfully');
    } else {
      print('Failed to delete task: ${response.statusCode}');
    }
  }
}
