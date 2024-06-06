import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart'; 

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bghome.png'), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}






// class BackgroundWidget extends StatelessWidget {
//   const BackgroundWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         //พื้นหลังสีเขียวตรงมุมซ้ายล่าง
//         Positioned(
//           left: -70,
//           bottom: -80,
//           child: Container(
//             width: 250,
//             height: 250,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [Colors.greenAccent.withOpacity(0.3), Colors.white],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//         ),
//         // พื้นหลังสีเขียวตรงมุมขวาบน
//         Positioned(
//           right: -170,
//           top: -10,
//           child: Container(
//             width: 270,
//             height: 240,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [Colors.greenAccent.withOpacity(0.3), Colors.white],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//         ),
//         //ตรงกลาง
//         Align(
//           alignment: Alignment.center,
//           child: Transform.translate(
//             offset: const Offset(-60, -60),
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.greenAccent.withOpacity(0.3),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// ใส่รูปเข้าไปแทน svg 
// decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: Svg('assets/images/iconsvgs/Ellipse6.svg'),
//                   fit: BoxFit.cover,
//                 ),