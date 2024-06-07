import 'package:http/http.dart' as http;

class DeleteTaskService {
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    'Content-Type': 'application/json'
  };

  static Future<void> deleteTask(int taskId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.27.143:6004/api/delete_todo/$taskId'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      print('Task deleted successfully');
    } else {
      print('Failed to delete task: ${response.statusCode}');
    }
  }
}
