import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:http/http.dart' as http;

class DeleteTaskService {
  static Future<void> deleteTask(int taskId) async {
    var request =
        http.Request('DELETE', Uri.parse('$baseUrl/delete_todo/$taskId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Todo deleted successfully');
    } else {
      throw Exception('Failed to delete todo: ${response.reasonPhrase}');
    }
  }
}
