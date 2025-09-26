import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/themes/app_themes.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isPrimary;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      width: isFullWidth ? double.infinity : null,
      decoration: isPrimary
          ? BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            )
          : BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: child,
      ),
    );

    return button.animate().scale(
      begin: const Offset(0.95, 0.95),
      duration: 200.ms,
      curve: Curves.easeOut,
    );
  }
}
