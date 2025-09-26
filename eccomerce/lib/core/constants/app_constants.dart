class AppConstants {
  static const String appName = 'Auth App';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String userKey = 'current_user';
  static const String tokenKey = 'auth_token';
  
  // Validation messages
  static const String requiredField = 'Este campo es obligatorio';
  static const String invalidEmail = 'Ingresa un correo electrónico válido';
  static const String shortPassword = 'La contraseña debe tener al menos 8 caracteres';
  static const String passwordsDontMatch = 'Las contraseñas no coinciden';
  static const String invalidPhone = 'Ingresa un teléfono válido';
}