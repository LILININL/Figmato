import 'dart:convert';
import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:http/http.dart' as http;

class TaskEditService {
  static Future<bool> updateTask(Map<String, dynamic> body) async {
    try {
      var request = http.Request('POST', Uri.parse('$baseUrl/update_todo/'));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print('Failed to update task: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Failed to update task: $e');
      return false;
    }
  }
}
