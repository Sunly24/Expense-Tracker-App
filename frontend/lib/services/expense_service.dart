import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';
import 'auth_service.dart';

class ExpenseService {
  static const String baseUrl = 'http://localhost:3000/';
  final AuthService _authService;

  ExpenseService(this._authService);

  Map<String, String> get _headers {
    final token = _authService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Expense>> fetchExpenses() async {
    if (!_authService.isAuthenticated) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/expenses'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Expense.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load expenses: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching expenses: $e');
    }
  }

  Future<void> addExpense(Expense expense) async {
    if (!_authService.isAuthenticated) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/expenses'),
        headers: _headers,
        body: json.encode(expense.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add expense: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding expense: $e');
    }
  }

  Future<void> updateExpense(String id, Expense expense) async {
    if (!_authService.isAuthenticated) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/expenses/$id'),
        headers: _headers,
        body: json.encode(expense.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update expense: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

  Future<void> deleteExpense(String id) async {
    if (!_authService.isAuthenticated) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/expenses/$id'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete expense: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting expense: $e');
    }
  }
}
