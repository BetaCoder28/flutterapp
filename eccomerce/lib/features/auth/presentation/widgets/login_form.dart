import 'package:flutter/material.dart';
import 'auth_text_form_field.dart';
import '../../../../core/utils/validators.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextFormField(
          controller: emailController,
          label: 'Correo Electrónico',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 20),
        AuthTextFormField(
          controller: passwordController,
          label: 'Contraseña',
          icon: Icons.lock_outlined,
          isPassword: true,
          validator: Validators.validatePassword,
        ),
      ],
    );
  }
}
