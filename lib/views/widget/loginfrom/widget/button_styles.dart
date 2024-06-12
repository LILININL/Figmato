import 'package:flutter/material.dart';

class SIGNUPButton {
  static ButtonStyle buildStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent, // เพิ่มเพื่อความแน่ใจว่าไม่มีเงา
      elevation: 0, // ปิดเงาปุ่ม
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.zero, // ลบ padding ออก
      minimumSize: const Size(double.infinity, 50),
    );
  }

  static Widget buildChild(String text) {
    return Opacity(
      opacity: 1,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(13, 122, 92, 1),
              Color.fromRGBO(0, 80, 62, 1),
            ],
          ),
          borderRadius:
              BorderRadius.circular(15.0), // ต้องตรงกับ shape ใน buildStyle
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white, // ตั้งค่าสีข้อความเป็นสีขาว
            ),
          ),
        ),
      ),
    );
  }
}

class SIGNINButton {
  static ButtonStyle buildStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      minimumSize: const Size(double.infinity, 50),
      padding: EdgeInsets.zero, // ลบ padding ออก
      elevation: 0, // ปิดเงาปุ่ม
    );
  }

  static Widget buildChild(String text) {
    return Opacity(
      opacity: 0.8,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(13, 122, 92, 1.0), // สี rgba(13, 122, 92, 1)
              Color.fromRGBO(83, 205, 159, 1.0), // สี rgba(83, 205, 159, 1)
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white, // ตั้งค่าสีข้อความเป็นสีขาว
            ),
          ),
        ),
      ),
    );
  }
}
