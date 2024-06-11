const String baseUrl = 'http://192.168.27.143:6004/api';

String getDeleteTodoUrl(String taskId) {
  
  return '$baseUrl/delete_todo/$taskId';
}

const Map<String, String> headers = {
  'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
  'Content-Type': 'application/json'
};
