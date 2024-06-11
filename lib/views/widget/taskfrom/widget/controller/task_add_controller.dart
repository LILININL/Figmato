import 'package:fristprofigmatest/services/task_add_service.dart';
import 'package:fristprofigmatest/utils/json/task_add_jsondata.dart';
import 'package:get/get.dart';

class TaskAddController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<bool> createTodo(TaskAddJsonData newTask) async {
    isLoading(true);
    try {
      final response = await TaskAddService.createTodo(newTask.toJson());
      if (response.statusCode == 200) {
        isSuccess(true);
        print(' สร้าง Todo สำเร็จ');
        return true;
      } else {
        isSuccess(false);
        print('สร้าง Todo ไม่สำเร็จ');
        return false;
      }
    } catch (e) {
      isSuccess(false);
      print('Error: $e ไม่สามารถเชื่อมต่อเชิฟเวอร์ได้');
      return false;
    } finally {
      isLoading(false);
    }
  }
}
