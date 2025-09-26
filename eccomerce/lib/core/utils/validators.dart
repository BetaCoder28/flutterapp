import 'package:eccomerce/core/constants/app_constants.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return AppConstants.invalidEmail;
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    if (value.length < 8) return AppConstants.shortPassword;
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    if (value.length < 2) return 'El nombre debe tener al menos 2 caracteres';
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    if (value.length < 2) return 'El apellido debe tener al menos 2 caracteres';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) return AppConstants.invalidPhone;
    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return AppConstants.requiredField;
    if (value != originalPassword) return AppConstants.passwordsDontMatch;
    return null;
  }
}