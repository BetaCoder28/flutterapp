import 'package:eccomerce/features/auth/data/datasources/auth_data_local_datasource.dart';
import 'package:eccomerce/features/auth/data/models/users_model.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<UserModel> login(String email, String password) async {
    final user = await localDataSource.login(email, password);
    if (user == null) {
      throw Exception('Credenciales inválidas');
    }
    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<UserModel> register(UserModel user) async {
    final newUser = await localDataSource.register(user); // <-- ya no es nullable
    await localDataSource.saveUser(newUser);
    return newUser;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await localDataSource.getCurrentUser();
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteUser();
  }
}
