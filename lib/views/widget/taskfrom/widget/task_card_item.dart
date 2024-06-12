import 'dart:math';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final int id;
  final String title;
  final String time;
  final String description;
  final bool isCompleted;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.time,
    required this.description,
    required this.isCompleted,
    required this.onChanged,
    required this.onEdit,
  });

  // ฟังก์ชันสุ่มสี
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // ความเข้มของสี (alpha)
      random.nextInt(256), // สีแดง (red)
      random.nextInt(256), // สีเขียว (green)
      random.nextInt(256), // สีน้ำเงิน (blue)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            offset: const Offset(0, 3),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        color: Colors.white.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 19),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 15, bottom: 17, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: const BorderSide(
                          color: Colors.grey, // สีของกรอบ
                          width: 1.5, // ความกว้างของกรอบ
                        ),
                        value: isCompleted,
                        onChanged: onChanged,
                        shape: const CircleBorder(eccentricity: 1),
                        hoverColor: Colors.transparent,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isCompleted ? Colors.green : getRandomColor(),
                          fontSize: 20,
                          height: 1.26),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black38,
                    ),
                    onPressed: onEdit,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                        height: 1.26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 128, 128, 128),
                        fontSize: 14,
                        height: 1.26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
