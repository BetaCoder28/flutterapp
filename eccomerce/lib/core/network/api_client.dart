// lib/core/network/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://127.0.0.1:3000/api/";
  
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpException(
        'Error HTTP ${response.statusCode}: ${response.body}',
        response.statusCode,
      );
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => message;
}