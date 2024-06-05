import 'package:flutter/material.dart';

class SIGNUPButton {
  static ButtonStyle buildStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero, // ลบ padding ออก
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minimumSize: const Size(double.infinity, 50),
      elevation: 0, // ปิดเงาปุ่ม
    );
  }

  static Widget buildChild(String text) {
    return Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(13, 122, 92, 1),
            Color.fromRGBO(0, 80, 62, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}





class SIGNINButton {
  static ButtonStyle buildStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero, // ลบ padding ออก
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minimumSize: const Size(double.infinity, 50),
      elevation: 0, // ปิดเงาปุ่ม
    );
  }

  static Widget buildChild(String text) {
    return Ink(
      decoration: BoxDecoration( 
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(83, 205, 159, 1),
            Color.fromRGBO(13, 122, 92, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
        
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style:  const TextStyle(
            fontSize: 18,
            color: Colors.white, // ตั้งค่าสีข้อความเป็นสีขาว
          ),
        ),
      ),
    );
  }
}


const TextStyle forgotPasswordStyle = TextStyle(
  color: Color.fromRGBO(45, 38, 38, 1),
);