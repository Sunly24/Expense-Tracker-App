import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3000';
  static const String tokenKey = 'auth_token';
  String? _token;
  bool _initialized = false;

  AuthService() {
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    if (!_initialized) {
      await _loadToken();
      _initialized = true;
    }
  }

  Future<void> _loadToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString(tokenKey);
    } catch (e) {
      debugPrint('Error loading token: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(tokenKey, token);
      _token = token;
    } catch (e) {
      debugPrint('Error saving token: $e');
    }
  }

  Future<void> _clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(tokenKey);
      _token = null;
    } catch (e) {
      debugPrint('Error clearing token: $e');
    }
  }

  String? getToken() => _token;

  bool get isAuthenticated => _token != null;

  Future<bool> login(String email, String password) async {
    await _initializeAsync(); // Ensure initialization

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveToken(data['token']);
        return true;
      }

      debugPrint('Login failed: ${response.body}');
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _clearToken();
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    await _initializeAsync(); // Ensure initialization

    try {
      // Generate a username from the email
      final username = email.split('@')[0];

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      debugPrint('Register response: ${response.body}');

      if (response.statusCode == 201) {
        // Try to login immediately after successful registration
        final loginSuccess = await login(email, password);
        if (loginSuccess) {
          return {'success': true, 'error': null};
        } else {
          return {
            'success': false,
            'error': 'Registration successful but login failed'
          };
        }
      }

      final responseData = json.decode(response.body);
      return {
        'success': false,
        'error': responseData['error'] ?? 'Registration failed'
      };
    } catch (e) {
      debugPrint('Registration error: $e');
      return {
        'success': false,
        'error': 'An error occurred during registration'
      };
    }
  }
}
