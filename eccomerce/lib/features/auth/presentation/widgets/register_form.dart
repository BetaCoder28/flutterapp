import 'package:flutter/material.dart';
import 'auth_text_form_field.dart';
import '../../../../core/utils/validators.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primera fila: Nombre y Apellido
        Row(
          children: [
            Expanded(
              child: AuthTextFormField(
                controller: nameController,
                label: 'Nombre',
                icon: Icons.person_outlined,
                validator: Validators.validateName,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: AuthTextFormField(
                controller: lastNameController,
                label: 'Apellido',
                icon: Icons.person_outlined,
                validator: Validators.validateLastName,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        AuthTextFormField(
          controller: phoneController,
          label: 'Teléfono',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhone,
        ),
        const SizedBox(height: 20),

        AuthTextFormField(
          controller: emailController,
          label: 'Correo Electrónico',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 20),

        // Segunda fila: Contraseña y Confirmar Contraseña
        Row(
          children: [
            Expanded(
              child: AuthTextFormField(
                controller: passwordController,
                label: 'Contraseña',
                icon: Icons.lock_outlined,
                isPassword: true,
                validator: Validators.validatePassword,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: AuthTextFormField(
                controller: confirmPasswordController,
                label: 'Confirmar',
                icon: Icons.lock_outlined,
                isPassword: true,
                validator: (value) => Validators.validateConfirmPassword(
                  value,
                  passwordController.text,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
