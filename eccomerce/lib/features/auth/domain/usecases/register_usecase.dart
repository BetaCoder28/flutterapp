import 'package:eccomerce/features/auth/data/models/users_model.dart';
import '../repositories/auth_repository.dart';


class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call(UserModel user) async {
    await repository.register(user);
  }
}