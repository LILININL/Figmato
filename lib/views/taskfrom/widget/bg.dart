import 'package:flutter/material.dart';

class MyAppGradients {
  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(13, 122, 92, 1),
      Color.fromRGBO(0, 80, 62, 1),
    ],
  );

  static BoxDecoration gradientBackground() {
    return const BoxDecoration(
      gradient: appBarGradient,
    );
  }

  static BoxDecoration imageBackground(String imagePath) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    );
  }
}
 var imageBackground = MyAppGradients.imageBackground('assets/images/taskappbbarbg.png');