// lib/features/auth/presentation/providers/auth_provider.dart
import 'package:eccomerce/features/auth/data/models/users_model.dart';
import 'package:flutter/foundation.dart';
import '../../data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _authService.login(email, password);
      _error = null;
      
      // Guardar token en almacenamiento local
      if (_currentUser?.accessToken != null) {
        await _saveToken(_currentUser!.accessToken!);
      }
    } catch (e) {
      _error = e.toString();
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _authService.register(
        name: name,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
      );
      _error = null;
      
      if (_currentUser?.accessToken != null) {
        await _saveToken(_currentUser!.accessToken!);
      }
    } catch (e) {
      _error = e.toString();
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if (_currentUser?.accessToken != null) {
        await _authService.logout(_currentUser!.accessToken!);
      }
    } catch (e) {
      print('Error en logout: $e');
    } finally {
      _currentUser = null;
      await _deleteToken();
      notifyListeners();
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await _getToken();
    if (token != null) {
      try {
        // Verificar token con el backend
        _currentUser = await _authService.getProfile(token);
      } catch (e) {
        await _deleteToken();
      }
    }
    notifyListeners();
  }

  // Métodos de almacenamiento local
  Future<void> _saveToken(String token) async {
    // Implementar con shared_preferences
    // await storage.saveData('auth_token', token);
  }

  Future<String?> _getToken() async {
    // return await storage.getData('auth_token');
    return null;
  }

  Future<void> _deleteToken() async {
    // await storage.removeData('auth_token');
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}