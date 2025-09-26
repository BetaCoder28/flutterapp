import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/themes/app_themes.dart';

class AuthTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _isPasswordVisible = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword && !_isPasswordVisible,
            validator: widget.validator,
            onTap: () => setState(() => _isFocused = true),
            onFieldSubmitted: (_) => setState(() => _isFocused = false),
            onEditingComplete: () => setState(() => _isFocused = false),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _isFocused ? AppTheme.primaryColor : Colors.black54,
                fontWeight: _isFocused ? FontWeight.w500 : FontWeight.w400,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isFocused
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: _isFocused ? AppTheme.primaryColor : Colors.grey[600],
                  size: 20,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _isFocused
                            ? AppTheme.primaryColor
                            : Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppTheme.errorColor, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppTheme.errorColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              hintStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black38),
            ),
          ),
        )
        .animate()
        .slideX(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
        .fadeIn(duration: 600.ms);
  }
}
