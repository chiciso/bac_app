import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum AppButtonStyle { primary, outline, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final AppButtonStyle style;
  final bool isLoading;
  final IconData? icon;
  final Color? color;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.style = AppButtonStyle.primary,
    this.isLoading = false,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isOutline = style == AppButtonStyle.outline;
    final isText = style == AppButtonStyle.text;
    
    final primaryColor = color ?? AppColors.primary;
    final contentColor = (isOutline || isText) ? primaryColor : Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: (isOutline || isText) ? Colors.transparent : primaryColor,
        borderRadius: BorderRadius.circular(16),
        shape: isOutline ? RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ) : null,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: isLoading 
              ? SizedBox(
                  height: 24, 
                  width: 24, 
                  child: CircularProgressIndicator(
                    strokeWidth: 2, 
                    color: contentColor,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: contentColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        color: contentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}