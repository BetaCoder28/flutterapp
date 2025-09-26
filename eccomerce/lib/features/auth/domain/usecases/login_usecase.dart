import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email y contraseña son requeridos');
    }
    await repository.login(email, password);
  }
}