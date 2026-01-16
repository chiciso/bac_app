import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller; // Add this
  final bool isPassword;
  final IconData? prefixIcon;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // Use it here
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
            // ... add your border styling here
          ),
        ),
      ],
    );
  }
}