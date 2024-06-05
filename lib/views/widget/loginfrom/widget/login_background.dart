import 'package:flutter/material.dart';

class loginBackgroundWidget extends StatelessWidget {
  const loginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // พื้นหลังสีเขียวตรงมุมขวาบน
        Positioned(
          right: -170,
          top: -50,
          child: Container(
            width: 270,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.greenAccent.withOpacity(0.3), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        //ตรงกลาง
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: const Offset(00, 50),
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(                
                shape: BoxShape.circle,
                gradient: LinearGradient(
                colors: [Colors.greenAccent.withOpacity(0.2), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// ใส่รูปเข้าไปแทน svg 
// decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: Svg('assets/images/iconsvgs/Ellipse6.svg'),
//                   fit: BoxFit.cover,
//                 ),