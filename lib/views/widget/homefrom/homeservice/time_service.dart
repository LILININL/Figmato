import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer {
  int _counter = 3; // จำนวนวินาทีที่ต้องการนับถอยหลัง
  late Timer _timer;
  final VoidCallback onFinished;
  final ValueChanged<int> onTick;

  CountdownTimer({required this.onFinished, required this.onTick});
  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (_counter > 0) {
        _counter--;
        onTick(_counter);
      } else {
        _timer.cancel();
        onFinished();
      }
    });
  }
  void cancelTimer() {
    _timer.cancel();
  }
}
