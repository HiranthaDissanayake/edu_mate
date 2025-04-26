import 'package:flutter/material.dart';

class AttendanceButton extends StatelessWidget {
  final String studentId;
  final int status; // 1 for Present, 0 for Absent
  final Function(String, String) onTap; // Callback function

  const AttendanceButton({
    super.key,
    required this.studentId,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(studentId, status == 1 ? 'Absent' : 'Present'),
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: status == 1 ? Colors.green : Colors.red, // Green = Present, Red = Absent
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
