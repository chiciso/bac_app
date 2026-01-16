import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final int year;
  final bool isCompleted;
  final VoidCallback onTap;

  const ExerciseTile({
    super.key,
    required this.year,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$year",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800, // Corrected from .black
                    letterSpacing: -0.5,
                  ),
                ),
                if (isCompleted)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(Icons.check_circle, size: 16, color: Colors.green.shade400),
                  ),
              ],
            ),
            if (year == 2024)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}