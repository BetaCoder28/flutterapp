import 'package:eccomerce/core/constants/app_constants.dart';
import 'package:eccomerce/features/auth/data/models/users_model.dart';
import 'package:eccomerce/shared/services/local_storage_service.dart';

class AuthLocalDataSource {
  final LocalStorageService localStorage;

  AuthLocalDataSource(this.localStorage);

  Future<UserModel?> getCurrentUser() async {
    final userData = await localStorage.getData(AppConstants.userKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    await localStorage.saveData(AppConstants.userKey, user.toJson());
  }

  Future<void> deleteUser() async {
    await localStorage.removeData(AppConstants.userKey);
  }

  // Simulación de base de datos local para demo
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simular llamada API
    
    // Usuario demo para testing
    if (email == 'demo@demo.com' && password == 'password123') {
      return UserModel(
        id: 1,
        name: 'Demo',
        lastname: 'User',
        email: email,
        phone: '1234567890',
        password: password,
        notificationToken: 'demo_token',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return null;
  }

  Future<UserModel> register(UserModel user) async {
  await Future.delayed(const Duration(seconds: 2));

  return UserModel(
    id: DateTime.now().millisecondsSinceEpoch,
    name: user.name,
    lastname: user.lastname,
    email: user.email,
    phone: user.phone,
    password: user.password,
    notificationToken: user.notificationToken,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
}
