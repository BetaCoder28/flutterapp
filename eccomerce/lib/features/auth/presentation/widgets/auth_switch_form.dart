import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/themes/app_themes.dart';

class AuthSwitchButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback? onPressed;

  const AuthSwitchButton({super.key, required this.isLogin, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isLogin ? Icons.person_add_outlined : Icons.login_outlined,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    isLogin
                        ? '¿No tienes cuenta? Regístrate aquí'
                        : '¿Ya tienes cuenta? Inicia sesión aquí',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
        .fadeIn(duration: 600.ms);
  }
}
