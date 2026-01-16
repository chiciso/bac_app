import 'package:flutter/material.dart';
class AppEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(message, style: const TextStyle(color: Colors.grey)),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            TextButton(onPressed: onRetry, child: const Text("Try Again")),
          ]
        ],
      ),
    );
  }
}