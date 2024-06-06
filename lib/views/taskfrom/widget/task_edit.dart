import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showTaskEditBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.green),
              title: const Text('Edit'),
              onTap: () {
                // Handle edit action
                Navigator.pop(context); // ปิด bottom sheet
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.green),
              title: const Text('Delete'),
              onTap: () {
                // Handle delete action
                Navigator.pop(context); // ปิด bottom sheet
              },
            ),
          ],
        ),
      );
    },
  );
}
