import 'dart:convert';
import 'package:eccomerce/features/auth/data/models/users_model.dart';
import '../../../../core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiClient.post('login', {
        'email': email,
        'password': password,
      });

      final responseData = jsonDecode(response.body);

      // Verificar si la respuesta contiene el usuario y token
      if (responseData['success'] == true && responseData['user'] != null) {
        return UserModel.fromJson(responseData['user']);
      } else {
        throw Exception(responseData['message'] ?? 'Error en el login');
      }
    } catch (e) {
      throw Exception('Error en login: $e');
    }
  }

  Future<UserModel> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post('register', {
        'name': name,
        'lastname': lastname,
        'email': email,
        'phone': phone,
        'password': password,
        'notification_token':
            'default_token', // Puedes obtenerlo de FCM después
      });

      final responseData = jsonDecode(response.body);

      // Verificar si la respuesta contiene el usuario y token
      if (responseData['success'] == true && responseData['user'] != null) {
        return UserModel.fromJson(responseData['user']);
      } else {
        throw Exception(responseData['message'] ?? 'Error en el registro');
      }
    } catch (e) {
      throw Exception('Error en registro: $e');
    }
  }

  Future<UserModel> getProfile(String token) async {
    try {
      // Implementar según tu endpoint de perfil
      final response = await _apiClient.get('profile');
      final responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } catch (e) {
      throw Exception('Error obteniendo perfil: $e');
    }
  }

  Future<void> logout(String token) async {
    try {
      await _apiClient.post('logout', {});
    } catch (e) {
      throw Exception('Error en logout: $e');
    }
  }
}
