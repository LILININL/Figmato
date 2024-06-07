import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String Email = 'useremail';
  static const String Fname = 'userfname';
  static const String Lname = 'userlname';
  static const String UserId = 'userid';

  static Future<void> saveUserInfo(
      int userId, String userEmail, String userFname, String userLname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(UserId, userId);
    await prefs.setString(Email, userEmail);
    await prefs.setString(Fname, userFname);
    await prefs.setString(Lname, userLname);
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      UserId: prefs.getInt(UserId),
      Email: prefs.getString(Email),
      Fname: prefs.getString(Fname),
      Lname: prefs.getString(Lname),
    };
  }

  static Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(UserId);
    await prefs.remove(Email);
    await prefs.remove(Fname);
    await prefs.remove(Lname);
  }
}
