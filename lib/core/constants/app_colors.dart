import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primary = Color(0xFF1976D2);
  static const primaryDark = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF42A5F5);
  
  // Accent Colors
  static const accent = Color(0xFF2196F3);
  static const accentDark = Color(0xFF1976D2);
  
  // Background Colors
  static const background = Color(0xFFF5F5F5);
  static const surface = Colors.white;
  static const surfaceVariant = Color(0xFFF8F9FA);
  
  // Text Colors
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF757575);
  static const textHint = Color(0xFFBDBDBD);
  
  // Semantic Colors
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFF9800);
  static const info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const grey50 = Color(0xFFFAFAFA);
  static const grey100 = Color(0xFFF5F5F5);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey300 = Color(0xFFE0E0E0);
  
  // Gradient
  static const gradientStart = Color(0xFF1976D2);
  static const gradientEnd = Color(0xFF42A5F5);
  
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}