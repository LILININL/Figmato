import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fristprofigmatest/route/route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance(); 
  });
  FlutterNativeSplash.remove(); 
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes, // ใช้การตั้งค่าเส้นทางจาก AppRoutes
    ),
  );
}
