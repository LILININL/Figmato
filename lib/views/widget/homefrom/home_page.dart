import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fristprofigmatest/views/widget/homefrom/%E0%B9%89homeservice/%E0%B9%89time_service.dart';
import 'package:fristprofigmatest/views/widget/homefrom/%E0%B9%89homeservice/home_background.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 5;
  late CountdownTimer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _countdownTimer = CountdownTimer(
      onFinished: () {
        Get.toNamed('/login');
      },
      onTick: (remainingTime) {
        setState(() {
          _counter = remainingTime;
        });
      },
    );
    _countdownTimer.startTimer();
  }

  @override
  void dispose() {
    _countdownTimer.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _countdownTimer.cancelTimer();
          Get.toNamed('/login');
        },
        child: Stack(
          children: [
            const BackgroundWidget(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 358.0,
                    width: 250.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: Svg('assets/images/iconsvgs/Frame.svg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text('Tap to Next Page or Wait $_counter', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
