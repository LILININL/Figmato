import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveUserData(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_password');
  }

  static Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
