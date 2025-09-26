import 'package:eccomerce/features/auth/data/models/users_model.dart';


abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user);
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
}