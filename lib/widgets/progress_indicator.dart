import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color color;

  const ProgressRing({super.key, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          backgroundColor: color.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: 6,
        ),
        Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}