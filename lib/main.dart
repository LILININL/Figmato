import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fristprofigmatest/route/route.dart';
import 'package:fristprofigmatest/utils/shared_preferences_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Get.putAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

// ตรวจสอบว่ามีข้อมูลผู้ใช้ใน SharedPreferences
  final userInfo = await SharedPreferencesHelper.getUserInfo();
  final bool isLoggedIn = userInfo[SharedPreferencesHelper.Fname] != null;

  FlutterNativeSplash.remove();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      initialRoute: determineInitialRoute(isLoggedIn),
      getPages: AppRoutes.routes, // ใช้การตั้งค่าเส้นทางจาก AppRoutes
    ),
  );
}
