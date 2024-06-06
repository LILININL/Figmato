import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final int id;
  final String title;
  final String time;
  final String description;
  final bool isCompleted;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;

  TaskItem({
    required this.id,
    required this.title,
    required this.time,
    required this.description,
    required this.isCompleted,
    required this.onChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24, // ขนาดของ Checkbox
              width: 24,  // ขนาดของ Checkbox
              child: Transform.scale(
                scale: 1.5, // เพิ่มขนาดของ Checkbox
                child: Checkbox(
                  value: isCompleted,
                  onChanged: onChanged,
                  shape: const CircleBorder(),
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16,height: 0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? Colors.green : Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8 ,width: 0,),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8,width: 0,),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16,height: 0,),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onEdit, // เรียกใช้ callback เมื่อกดปุ่ม
            ),
          ],
        ),
      ),
    );
  }
}
