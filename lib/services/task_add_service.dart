import 'dart:convert';
import 'package:fristprofigmatest/services/config/api_url_config.dart';
import 'package:http/http.dart' as http;

class TaskAddService {


  static Future<http.Response> createTodo(Map<String, dynamic> taskData) async {
  
    var request = http.Request('POST', Uri.parse('$baseUrl/create_todo'));
    request.body = json.encode(taskData);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await http.Response.fromStream(response);
    } else {
      throw Exception('Failed to create todo: ${response.reasonPhrase}');
    }
  }
}
